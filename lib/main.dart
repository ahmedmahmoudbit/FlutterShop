import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/homeScreen.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/shared/cubit/myBlocObserver.dart';
import 'package:shop_app/shared/network/SharedPreferences.dart';
import 'package:shop_app/shared/network/dio.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'modules/on_boarding/onBoarding.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();

  Widget widget;
  bool onBoarding = CashHelper.getData(key: 'onBoarding') == null ? false  : CashHelper.getData(key: 'onBoarding');
  dynamic token = CashHelper.getData(key: 'token') == null ? null : CashHelper.getData(key: 'token');

  print(token);
  print(onBoarding);

  if (onBoarding == true) {
    if (token != null) {
      widget = HomeScreen();
      print(token);
    } else
      widget = LoginScreen();
  } else
    widget = OnBoardingScreen();
  print(onBoarding);

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: startWidget,
    );
  }
}

