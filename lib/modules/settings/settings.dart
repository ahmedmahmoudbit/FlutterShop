import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var name = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context , state){

        var model = ShopCubit.get(context).userModel!.data;
        name.text = model!.name;
        phone.text = model.phone;
        email.text = model!.email;

        return BuildCondition(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context)=> Padding(
            padding: EdgeInsetsDirectional.all(10.0),
            child: Column(
              children: [
                defaultFormField(
                    controller: name,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "name must not be empty";
                      }
                      return null;
                    },
                    label: "name",
                    prefix: Icons.person_pin_rounded),
                SizedBox(height: 10,),
                defaultFormField(
                    controller: email,
                    type: TextInputType.emailAddress,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "email must not be empty";
                      }
                      return null;
                    },
                    label: "email",
                    prefix: Icons.email_rounded),
                SizedBox(height: 10,),
                defaultFormField(
                    controller: phone,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return "phone must not be empty";
                      }
                      return null;
                    },
                    label: "phone",
                    prefix: Icons.phone_iphone_rounded),
                SizedBox(height: 10,),
                defaultButton(
                    function: (){
                      signOut(context);
                    },
                    text: "log out"),
              ],
            ),
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
