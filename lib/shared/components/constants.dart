import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/shared/network/SharedPreferences.dart';
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
