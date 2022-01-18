import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categoryModel.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit =  ShopCubit.get(context);
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state) {},
      builder: (context , state) {
        return ListView.separated (
            itemBuilder: (context , index)=> buildCatItem(cubit.categoriesModel!.data!.data[index]) ,
            separatorBuilder: (context , index)=> Divider(height: 1,),
            itemCount: cubit.categoriesModel!.data!.data.length );
      },
    );
  }

  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage('${model.image}'),width: 80 , height: 80,fit: BoxFit.cover,),
        SizedBox(width: 20,),
        Text('${model.name}', style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
        Spacer(),
        Icon(Icons.arrow_forward_ios_rounded),

      ],
    ),
  );
}