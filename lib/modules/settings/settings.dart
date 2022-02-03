import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        return BuildCondition(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) =>
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.all(20.0),
                    child: Column(
                      children: [
                        if (state is UpdateLoadingState)
                        LinearProgressIndicator(),
                        // ------------------------------------ name
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "name must not be empty";
                              }
                              return null;
                            },
                            label: "name",
                            prefix: Icons.person_pin_rounded),

                        // ------------------------------------ email
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "email must not be empty";
                              }
                              return null;
                            },
                            label: "email",
                            prefix: Icons.email_rounded),
                        // ------------------------------------ phone

                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "phone must not be empty";
                              }
                              return null;
                            },
                            label: "phone",
                            prefix: Icons.phone_iphone_rounded),
                        // ------------------------- check data is empty or no .
                        defaultButton(
                          background: HexColor('FACE7F'),
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).updateProfileData(
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    name: nameController.text);
                              }
                            },
                            text: "Update"),
                        SizedBox(height: 10,),
                        defaultButton(
                            function: () {
                              signOut(context);
                            },
                            text: "log out"),
                      ],
                    ),
                  ),
                ),
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
