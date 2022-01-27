import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/models/user_data.dart';

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
  final ProfileDataModel model;
  ShopSuccessGetSettingDataState(this.model);
}

class ShopErrorGetSettingDataState extends ShopStates {
  final String? error;
  ShopErrorGetSettingDataState(this.error);
}



