import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/shopLayout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/SharedPreferences.dart';
import 'package:shop_app/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.registerModel!.status!) {
            showToast(
                message: state.registerModel!.message!,
                toastStates: ToastStates.SUCCESS);

            CacheHelper.saveData(
                key: 'token', value: state.registerModel!.data!.token)
                .then((value) {
              token = state.registerModel!.data!.token;
              navigateFinish(context, ShopLayout());
            });
          } else {
            showToast(
                message: state.registerModel!.message!,
                toastStates: ToastStates.ERROR);
          }
        }
      },
      builder: (context, states) {
        return Scaffold(
          appBar: AppBar(),
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
                      Text(
                        'Register',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: colorDefault, fontSize: 33),
                      ),
                      // ------------------------------------ name
                      SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'isEmpty';
                            }
                          },
                          label: 'name',
                          prefix: Icons.person),
                      // ------------------------------------ email
                      SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'isEmpty';
                            }
                          },
                          label: 'email',
                          prefix: Icons.email),
                      // ------------------------------------ phone
                      SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'isEmpty';
                            }
                          },
                          label: 'phone',
                          prefix: Icons.email),
                      // ------------------------------------ password
                      SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: ShopCubit.get(context).isPasswordShow,
                          suffixPressed: () {
                            ShopCubit.get(context).changePassword();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'isEmpty';
                            }
                          },
                          label: 'label',
                          // لجعل النقر على زر تم تنفيذ عملية زر الدخول بدلا من النقر عليها
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  name: nameController.text);
                            }
                          },
                          suffix: ShopCubit.get(context).suffix,
                          prefix: Icons.lock_outline_rounded),
                      // ------------------------------------ button login .
                      SizedBox(
                        height: 20,
                      ),
                      BuildCondition(
                        condition: states is! RegisterLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                name: nameController.text,
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
