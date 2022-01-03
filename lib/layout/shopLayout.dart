import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener:  (context, state) {},
      builder:  (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_max_rounded) , label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.drag_indicator) , label: "category"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded) , label: "favorite"),
              BottomNavigationBarItem(icon: Icon(Icons.settings) , label: "settings"),
            ],
          ),
        );
      },
    );
  }
}
