import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/RegisterModel.dart';
import 'package:shop_app/models/SearchModel.dart';
import 'package:shop_app/models/categoryModel.dart';
import 'package:shop_app/models/favorites.dart';
import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/models/get_cart.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/models/productDetailsModel.dart';
import 'package:shop_app/models/user_data.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/models/changeCart.dart';
import 'package:shop_app/modules/favourite/favourite.dart';
import 'package:shop_app/modules/home/homeScreen.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/SharedPreferences.dart';
import 'package:shop_app/shared/network/dio.dart';
import 'package:shop_app/shared/network/endPoints.dart';

import '../../translation.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_rounded;
  bool isPasswordShow = true;
  int currentIndex = 0;

  int? maxLines;
  bool seeMore = true;

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

  void changePassword() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_rounded
        : Icons.visibility_off_rounded;
    emit(LoginChangePasswordState());

  }

  void descriptionView() {
    if (seeMore) {
      maxLines = null;
      seeMore = false;
      emit(ShowMoreState());
    } else {
      maxLines = 6;
      seeMore = true;
      emit(ShowMoreState());
    }
  }

  // ---------------------------------------- post login

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
    });
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
          element.id!: element.inFavorites!,
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
            data: {'product_id': id}, url: END_FAVORITE, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // if state is false = remove fill color
      if (!changeFavoritesModel!.state!) {
        favorites[id] = !favorites[id]!;
      } else {
        // if true send item to favorite.
        getFavorite();
      }

      emit(ShopFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((onError) {
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
    DioHelper.getData(url: END_FAVORITE, token: token).then((value) {
      favoritesModel = ShopFavoritesModel.fromJson(value.data);

      emit(ShopFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesDataState(error.toString()));
    });
  }

// ---------------------------------------- get profile data

  UserDataModel? userModel;

  void getSettingData() {
    emit(ShopLoadingGetSettingDataState());
    print('name is error ');
    DioHelper.getData(url: END_SETTING, token: token).then((value) {
      userModel = UserDataModel.fromJson(value.data);
      emit(ShopSuccessGetSettingDataState(userModel!));
    }).catchError((onError) {
      print(onError.toString());
      print('name is error ');
      emit(ShopErrorGetSettingDataState(onError.toString()));
    });
  }

// ---------------------------------------- post Register

  RegisterModel? registerModel;

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: END_REGISTER, data: {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel));
    }).catchError((onError) {
      emit(RegisterErrorState(onError.toString()));
    });
  }

// ---------------------------------------- put update-profile

  void updateProfileData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UpdateLoadingState());
    DioHelper.putData(
      url: END_UPDATE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = UserDataModel.fromJson(value.data);
      emit(UpdateSuccessState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(UpdateErrorState(error.toString()));
    });
  }

// ---------------------------------------- get product Details
  ProductDetailsModel? productDetailsModel;

  void getProductDetails({
    required int productId,
  }) {
    productDetailsModel = null;
    seeMore = true;
    maxLines = 6;
    emit(DetailsLoadingProductDetailsState());
    DioHelper.getData(url: '$END_PRODUCTS$productId', token: token).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print('----------------------------getProductDetails success');
      print(productDetailsModel!.data!.name);
      emit(DetailsSuccessProductDetailsState());
    }).catchError((error) {
      print(error.toString());
      emit(DetailsErrorProductDetailsState(error.toString()));
    });
  }
// ---------------------------------------- post search
  SearchModel? searchModel;

  void getSearch(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: END_SEARCH, data: {
       'text': text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.data!.data);
      emit(SearchSuccessState());
    }).catchError((onError) {
      emit(SearchErrorState(onError.toString()));
    });
  }

// ---------------------------------------- get cart product

  GetCartModel? getCartModel;

  Future<void> getCartData() async {
    emit(ShopLoadingGetCartDataState());
    DioHelper.getData(url: END_CART, token: token).then((value) {
      getCartModel = GetCartModel.fromJson(value.data);
      print('----------------------------SuccessGetCartData');
      print(getCartModel!.data!.cartItems.length);
      print(getCartModel!.data!.cartItems[0].product.name);
      emit(ShopSuccessGetCartDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetCartDataState(error.toString()));
    });
  }


// ---------------------------------------- change cart

  ChangeCartModel? changeCartModel;

  Map<int, bool> cart = {};

  void changeCart(int productId) {
    cart[productId] = !cart[productId]!;
    emit(ShopLoadingChangeCartTestDataState());
    DioHelper.postData(
      data: {
        'product_id': productId,
      },
      url: END_CART,
      token: token,
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      if (!changeCartModel!.status) {
        cart[productId] = !cart[productId]!;
      } else {
        getCartData();
      }
      print('change success');
      emit(ShopSuccessChangeCartDataState(changeCartModel!));
    }).catchError((error) {
      cart[productId] = !cart[productId]!;
      emit(ShopErrorChangeCartDataState(error, changeCartModel!));
    });
  }

// ---------------------------------------- Translation
  void changeLanguage() async {
    isRtl = !isRtl;

    CacheHelper.saveData(key: 'isRtl' , value: isRtl);
    String translation = await rootBundle
        .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');
    setTranslation(
      translation: translation,
    );

    emit(ChangeLanguageState());
  }

  late TranslationModel translationModel;

  void setTranslation({
    required String translation,
  }) {
    translationModel = TranslationModel.fromJson(json.decode(
      translation,
    ));
    emit(LanguageLoaded());
  }

  // ------------------------------------ no internet

  bool noInternetConnection = false;

  void checkConnectivity() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      debugPrint('Internet Connection ------------------------');
      debugPrint('${result.index}');
      debugPrint(result.toString());
      if (result.index == 0 || result.index == 1) {
        noInternetConnection = false;
      } else if (result.index == 2) {
        noInternetConnection = true;
      }

      emit(InternetState());
    });
  }

  void checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      noInternetConnection = false;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      noInternetConnection = false;
    } else {
      noInternetConnection = true;
    }
    emit(InternetState());
  }

}
