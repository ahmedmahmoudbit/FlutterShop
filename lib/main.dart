import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/shopLayout.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/myBlocObserver.dart';
import 'package:shop_app/shared/network/SharedPreferences.dart';
import 'package:shop_app/shared/network/dio.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'modules/on_boarding/onBoarding.dart';
import 'shared/components/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') == null ? false  : CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token') == null ? null : CacheHelper.getData(key: 'token');

  print(token);
  print(onBoarding);

  if (onBoarding == true) {
    if (token != null) {
      widget = ShopLayout();
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
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorite()..getSettingData(),
      child: BlocConsumer<ShopCubit , ShopStates> (
        listener:  (context, state) {},
        builder:  (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}

