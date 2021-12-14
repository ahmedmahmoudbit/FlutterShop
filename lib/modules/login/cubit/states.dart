import 'package:shop_app/models/loginModel.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel? loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginChangePasswordState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String? error;
  LoginErrorState(this.error);
}