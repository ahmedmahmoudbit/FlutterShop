// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/favorites.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/colors.dart';

void navigateTo(context , widget)=>
    Navigator.push(context, MaterialPageRoute(
        builder: (context)=> widget));

void navigateFinish(context , widget)=>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context)=> widget) , (Route<dynamic> route)=> false,);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool isClickable = true,
}) =>

    Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
            ),
          )
              : null,
          border: OutlineInputBorder(),
        ),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.redAccent,
  bool isUpperCase = true,
  double radius = 12.0,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget cartButton({required int productId, required BuildContext context}) {
  return SizedBox(
    height: 45.0,
    child: Container(
      width: double.infinity,
      child: MaterialButton(
        onPressed: () {
          if(isInProgress != true){
            ShopCubit.get(context).changeCart(productId);
          }else{
            showToast(message: 'Your order is in progress', toastStates: ToastStates.WARNING);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ShopCubit.get(context).cart[productId]!
                  ? isInProgress != true ? 'Remove From' : 'In Progress'
                  : 'Add To',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Icon(
              ShopCubit.get(context).cart[productId]!
                  ? isInProgress != true ? Icons.remove_shopping_cart_outlined : null
                  : Icons.add_shopping_cart_outlined,
              size: 20.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          6.0,
        ),
        color:
        ShopCubit.get(context).cart[productId]! ? isInProgress != true ? Colors.red : Colors.green : Colors.blue,
      ),
    ), // child: defaultButton(
  );
}


Widget defaultTextButton({
  required Function() function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

void showToast({
  required String message,
  required ToastStates toastStates,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: choseToastColor(toastStates),
        textColor: Colors.white,
        fontSize: 16.0);

Widget buildFavItem(model , context , {bool isOldPrice = true})=> Container(
  height: 150,
  width: double.infinity,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: [
          Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: NetworkImage('${model.image}'),
                        height: 120,
                        width: 120,
                      ),
                    ),
                    if(model.discount !=0 && isOldPrice)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          color: Colors.deepOrange,
                          child: Text('Discount' , style: TextStyle(fontSize: 10 , color: Colors.white),),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${model.name}' , maxLines: 1 , overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: TextStyle(fontSize: 15),),
                      Row(
                        children: [
                          Text('${model.price.toString()}' ,style: TextStyle(color: Colors.deepOrange)),
                          SizedBox(
                            width: 5,
                          ),
                          Spacer(),
                        ],
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 3),
                          child: Text('${model.oldPrice} E.G' ,style: TextStyle(color: Colors.grey , fontSize: 7 , decoration: TextDecoration.lineThrough)),
                        ),
                      SizedBox(height: 5,),
                      if(model.discount != 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          margin: const EdgeInsetsDirectional.only(bottom: 5),
                          color: Colors.deepOrange,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('Discount' , style: TextStyle(fontSize: 10 , color: Colors.white),),
                          ),
                        ),
                    ],
                  ),
                ),
              ]
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: CircleAvatar(
                  radius: 50,
                  backgroundColor: ShopCubit.get(context).favorites[model.id]! ? Colors.redAccent: Colors.grey,
                  child: Icon(ShopCubit.get(context).favorites[model.id]! ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: Colors.white, size: 18,) ),
              onPressed: (){
                ShopCubit.get(context).changeFavorites(model.id);
              },
            ),
          ),
        ],

      ),
    ),
  ),
);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color choseToastColor(ToastStates toastStates) {
  Color color;
  switch (toastStates) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}




