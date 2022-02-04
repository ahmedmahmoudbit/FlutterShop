import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/shared/network/SharedPreferences.dart';
import '../../translation.dart';
import 'components.dart';

bool? isInProgress;
String? token;

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      showToast(
          message: 'Sign out Successfully', toastStates: ToastStates.SUCCESS);
      navigateFinish(context, LoginScreen());
    }
  });
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

// ------------------- Translation
bool isRtl = false;

TranslationModel appTranslation(context) =>
    ShopCubit.get(context).translationModel;

String displayTranslatedText({
  required BuildContext context,
  required String ar,
  required String en,
}) => isRtl ? ar : en;


