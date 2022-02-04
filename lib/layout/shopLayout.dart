import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/InternetConnectionPage.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class ShopLayout extends StatefulWidget {
  ShopLayout({Key? key}) : super(key: key);

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Directionality(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: BuildCondition(
              condition: !ShopCubit.  get(context).noInternetConnection,
              builder: (context)=> Scaffold(
              appBar: AppBar(
              centerTitle: true,
              title: Text("Shop App"),
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                    onTap: (){
                      ShopCubit.get(context).changeLanguage();
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.wallpaperscraft.com/image/single/building_showcase_art_140944_1280x720.jpg'),
                      radius: 3,
                    )),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search_rounded))
              ],
            ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_max_rounded), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.drag_indicator), label: "category"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded), label: "favorite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "settings"),
            ],
          ),
        ),
              fallback: (context)=> const InternetConnectionPage(),
            ));
      },
    );
  }
}
