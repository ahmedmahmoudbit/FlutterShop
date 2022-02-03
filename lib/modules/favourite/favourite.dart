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
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, states) {},
      builder: (context, states) {
        return BuildCondition(
          // state not loading.
            condition: states is! ShopLoadingGetFavoritesDataState,
            // condition is achieved
            builder: (contetx) =>
                ListView.separated(
                  // bounded scroll .
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data[index].product, context),
                    separatorBuilder: (context, index) => SizedBox(height: 5,),
                    itemCount: ShopCubit .get(context).favoritesModel!.data!.data.length),
            // condition not achieved
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }
  }