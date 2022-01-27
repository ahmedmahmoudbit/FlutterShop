import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites.dart';
import 'package:shop_app/shared/components/components.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , states) {},
      builder: (context , states) {
        return BuildCondition(
          // state not loading.
          condition: states is! ShopLoadingGetFavoritesDataState,
          // condition is achieved
          builder: (contetx)=>ListView.separated(
            // bounded scroll .
              physics: BouncingScrollPhysics(),
              itemBuilder: (context , index)=> buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data[index] , context),
              separatorBuilder: (context , index)=> SizedBox(height: 5,),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length),
          // condition not achieved
          fallback: (context)=> Center(child: CircularProgressIndicator()));
      },
    );

      }
      Widget buildFavItem(FavoriteData model , context)=> Container(
        height: 150,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 3,
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
                              image: NetworkImage('${model.product.image}'),
                              height: 120,
                              width: 120,
                            ),
                          ),
                          // if(model.discount !=0)
                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${model.product.name}' , maxLines: 1 , overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: TextStyle(fontSize: 15),),
                            Row(
                              children: [
                                Text('${model.product.price.toString()}' ,style: TextStyle(color: Colors.deepOrange)),
                                SizedBox(
                                  width: 5,
                                ),
                                Spacer(),
                              ],
                            ),
                            if (model.product.discount != 0 )
                              Text('${model.product.oldPrice.toString()}' ,style: TextStyle(color: Colors.grey , fontSize: 8.5 , decoration: TextDecoration.lineThrough)),
                            SizedBox(height: 5,),
                            if(model.product.discount != 0)
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
                        backgroundColor: ShopCubit.get(context).favorites[model.product.id]! ? Colors.redAccent: Colors.grey,
                        child: Icon(ShopCubit.get(context).favorites[model.product.id]! ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: Colors.white, size: 18,) ),
                    onPressed: (){
                      ShopCubit.get(context).changeFavorites(model.product.id);
                    },
                  ),
                ),
              ],

            ),
          ),
        ),
      );
  }