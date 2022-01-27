
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categoryModel.dart';
import 'package:shop_app/models/favorites.dart';
import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/models/user_data.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favourite/favourite.dart';
import 'package:shop_app/modules/home/homeScreen.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/dio.dart';
import 'package:shop_app/shared/network/endPoints.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  List<Widget> bottomScreen = [
    HomeScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeState());
  }

  // ---------------------------------------- post login

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email':email,
      'password':password,
    }) .then((value){
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_rounded;
  bool isPasswordShow = true;

  void changePassword() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(LoginChangePasswordState());
  }

  // ---------------------------------------- get HomeData

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  ChangeFavoritesModel? changeFavoritesModel;

  void getHomeData() {
    emit(ShopLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
        element.id! : element.inFavorites! ,
        });
      });

      print(favorites.toString());

      emit(ShopSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorState(error.toString()));
    });
  }

  // ---------------------------------------- change Favorites from home

  void changeFavorites(int id) {
    // change not color to fill color , if true = still fill color if no remove fill color .
    favorites[id] = !favorites[id]!;
    emit(ShopFavoritesChangeState());

    DioHelper.postData(
        // Data = Body from api .
        data: {'product_id' : id},
        url: END_FAVORITE,
        token: token
    ).then((value){
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // if state is false = remove fill color
      if (!changeFavoritesModel!.state!) {
        favorites[id] = !favorites[id]!;
      } else {
        // if true send item to favorite.
        getFavorite();
      }

      emit(ShopFavoritesSuccessState(changeFavoritesModel!));

    }).catchError((onError){
      // if Error = remove fill color
      favorites[id] = !favorites[id]!;
      emit(ShopErrorFavoritesState(onError.toString()));
    });
  }

  // ---------------------------------------- get Categories

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(url: CATEGORY).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  // ----------------------------------------get Favorites

  ShopFavoritesModel? favoritesModel;

  void getFavorite() {
    emit(ShopLoadingGetFavoritesDataState());
    DioHelper.getData(
        url: END_FAVORITE,
        token: token
    ).then((value) {
      favoritesModel = ShopFavoritesModel.fromJson(value.data);

      emit(ShopFavoritesSuccessState(changeFavoritesModel!));

    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesDataState(error.toString()));
    });
  }

// ---------------------------------------- get profile data

  ProfileDataModel? userModel;

  void getSettingData() {
    emit(ShopLoadingGetSettingDataState());
    print('name is error ');
    DioHelper.getData(
        url: END_SETTING,
        token: token).then((value){
      userModel = ProfileDataModel.fromJson(value.data);
      emit(ShopSuccessGetSettingDataState(userModel!));
    }).catchError((onError) {
      print(onError.toString());
      print('name is error ');
      emit(ShopErrorGetSettingDataState(onError.toString()));
    });
  }

}