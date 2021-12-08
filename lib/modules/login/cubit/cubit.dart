// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/dio.dart';
import 'package:shop_app/shared/network/endPoints.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context)=> BlocProvider.of(context);

  void userLogin({
  required String email,
  required String password,
}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email':email,
      'password':password,
    }) .then((value){
      print(value.data);
      emit(LoginSuccessState());
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_rounded;
  bool isPasswordShow = true;

  void changePassword(){
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(LoginChangePasswordState());

  }

}