import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/shopLayout.dart';
import 'package:shop_app/modules/home/homeScreen.dart';
import 'package:shop_app/modules/register/registerScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/SharedPreferences.dart';
import 'package:shop_app/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , states) {

        if (states is LoginSuccessState) {
          if (states.loginModel!.status) {
            print(states.loginModel!.message);
            print(states.loginModel!.data!.token);
            showToast(
                message: states.loginModel!.message,
                toastStates: ToastStates.SUCCESS);

            CacheHelper.saveData(
                key: 'token', value: states.loginModel!.data!.token)
                .then((value) {
                  token = states.loginModel!.data!.token;
              navigateFinish(context, ShopLayout());
            });

          } else {
            showToast(
                message: states.loginModel!.message,
                toastStates: ToastStates.ERROR);
          }

        }
      },
      builder: (context , states) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login' , style: Theme.of(context).textTheme.bodyText1!.copyWith(color: colorDefault, fontSize: 33),),
                      SizedBox(height: 10,),
                      defaultFormField(controller: emailController
                          ,
                          type: TextInputType.emailAddress,
                          validate: (String? value){
                            if (value!.isEmpty) {
                              return 'isEmpty';
                            }
                          },
                          label: 'label',
                          prefix: Icons.mail_rounded),
                      defaultFormField(controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: ShopCubit.get(context).isPasswordShow,
                          suffixPressed: (){
                            ShopCubit.get(context).changePassword();
                          },
                          validate: (String? value){
                            if (value!.isEmpty) {
                              return 'isEmpty';
                            }
                          },
                          label: 'label',
                          // لجعل النقر على زر تم تنفيذ عملية زر الدخول بدلا من النقر عليها
                          onSubmit: (value){
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },

                          suffix: ShopCubit.get(context).suffix,
                          prefix: Icons.lock_outline_rounded),
                      SizedBox(height: 20,),
                      defaultTextButton(function: (){
                        navigateTo(context, RegisterScreen());
                      }, text: 'Don\'t Have an account ?'),
                      SizedBox(height: 20,),
                      BuildCondition(
                        condition: states is! LoginLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'login',
                          isUpperCase: true,
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}