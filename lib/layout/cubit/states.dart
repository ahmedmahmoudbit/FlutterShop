import 'package:shop_app/models/RegisterModel.dart';
import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/models/user_data.dart';
import 'package:shop_app/models/changeCart.dart';

abstract class ShopStates  {}

class ShopInitialState extends ShopStates {}

class LoginLoadingState extends ShopStates {}

class LoginSuccessState extends ShopStates {
  final LoginModel? loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginChangePasswordState extends ShopStates {}

class LoginErrorState extends ShopStates {
  final String? error;
  LoginErrorState(this.error);
}

class ShopChangeState extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopSuccessState extends ShopStates {}

class ShopErrorState extends ShopStates {
  final String? error;
  ShopErrorState(this.error);
}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String? error;
  ShopErrorCategoriesState(this.error);
}

class ShopFavoritesSuccessState extends ShopStates {
  final ChangeFavoritesModel model;
  ShopFavoritesSuccessState(this.model);
}

class ShopFavoritesChangeState extends ShopStates {}

class ShopErrorFavoritesState extends ShopStates {
  final String? error;
  ShopErrorFavoritesState(this.error);
}

class ShopLoadingGetFavoritesDataState extends ShopStates {}

class ShopSuccessGetFavoritesDataState extends ShopStates {}

class ShopErrorGetFavoritesDataState extends ShopStates {
  final String? error;
  ShopErrorGetFavoritesDataState(this.error);
}

class ShopLoadingGetSettingDataState extends ShopStates {
}

class ShopSuccessGetSettingDataState extends ShopStates {
  final UserDataModel model;
  ShopSuccessGetSettingDataState(this.model);
}

class ShopErrorGetSettingDataState extends ShopStates {
  final String? error;
  ShopErrorGetSettingDataState(this.error);
}

// -------------------- register

class RegisterLoadingState extends ShopStates {}

class RegisterSuccessState extends ShopStates {
  final RegisterModel? registerModel;
  RegisterSuccessState(this.registerModel);
}

class RegisterChangePasswordState extends ShopStates {}

class RegisterErrorState extends ShopStates {
  final String? error;
  RegisterErrorState(this.error);
}

// -------------------- update profile

class UpdateLoadingState extends ShopStates {}

class UpdateSuccessState extends ShopStates {
  final UserDataModel? userModel;
  UpdateSuccessState(this.userModel);
}

class UpdateErrorState extends ShopStates {
  final String? error;
  UpdateErrorState(this.error);
}

// -------------------- Details

class ShowMoreState extends ShopStates {}

class DetailsLoadingProductDetailsState extends ShopStates {}

class DetailsSuccessProductDetailsState extends ShopStates {}

class DetailsErrorProductDetailsState extends ShopStates {
  final String error;

  DetailsErrorProductDetailsState(this.error);
}

// -------------------- search

class SearchLoadingState extends ShopStates {}

class SearchSuccessState extends ShopStates {
}

class SearchChangePasswordState extends ShopStates {}

class SearchErrorState extends ShopStates {
  final String? error;
  SearchErrorState(this.error);
}

// -------------------- get cart product

class ShopSuccessGetCartDataState extends ShopStates {}

class ShopLoadingGetCartDataState extends ShopStates {}

class ShopErrorGetCartDataState extends ShopStates {
  final String error;
  ShopErrorGetCartDataState(this.error);
}

// -------------------- change cart

class ShopSuccessChangeCartDataState extends ShopStates {
  final ChangeCartModel changeCartModel;

  ShopSuccessChangeCartDataState(this.changeCartModel);
}

class ShopSuccessChangeCartTestDataState extends ShopStates {}

class ShopLoadingChangeCartTestDataState extends ShopStates {}

class ShopErrorChangeCartDataState extends ShopStates {
  final String error;
  final ChangeCartModel changeCartModel;
  ShopErrorChangeCartDataState(this.error, this.changeCartModel);
}
