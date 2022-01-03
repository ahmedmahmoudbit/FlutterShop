import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
// لون اتطبيق الرئيسي
  primarySwatch: Colors.grey,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: colorDefault,
  ),
  scaffoldBackgroundColor: colorDefault,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
        color: Colors.white
    ),
// سماح بتغيير لون الشريط العلوي

    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
// لون شريط الايقونات
        statusBarColor: HexColor('2B2B2B'),
// لون الايقونات
        statusBarIconBrightness : Brightness.light
    ),
    titleTextStyle: TextStyle(color: Colors.white , fontSize: 18.0 , fontWeight: FontWeight.bold),
    backgroundColor: HexColor('2B2B2B'),
    elevation: 1.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: HexColor('2B2B2B'),
    elevation: 20.0,

    selectedItemColor: HexColor('EED6C4'),
    unselectedItemColor: colorDefault,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 18 , color: Colors.white , fontWeight: FontWeight.bold
    ),
    bodyText2: TextStyle( fontSize: 14 , color: Colors.white , fontWeight: FontWeight.bold),

  ),
  fontFamily: 'Bals',
);

ThemeData lightTheme = ThemeData(
// لون اتطبيق الرئيسي
primarySwatch: Colors.red,
textTheme: TextTheme(
bodyText1: TextStyle(
fontSize: 18 , color: HexColor('212121') , fontWeight: FontWeight.bold
),
bodyText2: TextStyle( fontSize: 14 , color: HexColor('4A403A') , fontWeight: FontWeight.bold),
),
fontFamily: 'Bals',
floatingActionButtonTheme: FloatingActionButtonThemeData(
backgroundColor: colorDefault,
),
scaffoldBackgroundColor: Colors.white,
appBarTheme: AppBarTheme(
iconTheme: IconThemeData(
color: Colors.black54
),
// سماح بتغيير لون الشريط العلوي
// سماح بتغيير لون الشريط العلوي
backwardsCompatibility: false,
systemOverlayStyle: SystemUiOverlayStyle(
// لون شريط الايقونات
statusBarColor: Colors.white,
// لون الايقونات
statusBarIconBrightness : Brightness.dark
),
titleTextStyle: TextStyle(color: Colors.black , fontSize: 18.0 , fontWeight: FontWeight.bold),
backgroundColor: Colors.white,
elevation: 1.0,
),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
type: BottomNavigationBarType.fixed,
elevation: 20.0,
selectedItemColor: colorDefault,
)
);