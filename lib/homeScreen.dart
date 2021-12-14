// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/shared/network/SharedPreferences.dart';

import 'shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop App' , style: TextStyle(fontFamily: 'Jannah'),),
        centerTitle: true,
      ),
      body: Center(
        child: defaultButton(
          text: 'LOGOUT',
          width: 120,
          isUpperCase: true,
          background: Colors.redAccent,
          radius: 18,
          function: (){
            CashHelper.removeData(key: 'token').then((value) {
              if (value) {
                navigateFinish(context, LoginScreen());
              }
            });
          }
        ),
      ),
    );
  }
}
