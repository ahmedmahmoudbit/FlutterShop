// ignore_for_file: file_names
import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categoryModel.dart';
import 'package:shop_app/models/homeModel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
        listener: (context , states) {},
        builder: (context , states) {
          var cubit = ShopCubit.get(context);
          return BuildCondition(
            // ignore: unnecessary_null_comparison
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context) =>
            productsBuilder(cubit.homeModel , cubit.categoriesModel , context),
            fallback: (context) => progressIndicator(),
          );
        },
    );
  }
  Widget productsBuilder(HomeModel? model ,CategoriesModel? categories , context)=> SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: CarouselSlider(
            items: model!.data!.banners
                .map(
                  (e) => ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image(
                  image: NetworkImage('${e.image}'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ).toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 4.2,
              initialPage: 1,
              viewportFraction: .85,
              enableInfiniteScroll: true,
              // enable image above image another
              // enlargeStrategy: CenterPageEnlargeStrategy.height,

              reverse: false,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 2),
              autoPlayCurve: Curves.linearToEaseOut,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        SizedBox(height: 20,),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories' , style: TextStyle(fontSize: 22),),
                SizedBox(height: 10,),
                Container(
                  height: 100,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=> buildCategoryItem(categories!.data!.data[index] , context) ,
                      separatorBuilder: (context,index)=> SizedBox(width: 7,),
                      itemCount: categories!.data!.data.length),
                ),
                SizedBox(height: 20,),
                Text('Products' , style: TextStyle(fontSize: 22),),
              ],
            )
        ),
        SizedBox(height: 20,),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1 / 1.45,
          children: List.generate(
            model.data!.products.length,
                (index) => buildImages(
                model.data!.products[index], context),
          ),
        ),
      ],
    ),
  );

  Widget progressIndicator()=> Center(
      child: CircularProgressIndicator());

  Widget buildImages(ProductsModel model , context)=> Padding(
    padding: const EdgeInsets.all(5.0),
    child: Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                height: 180,
                width: double.infinity,
              ),
              if(model.discount !=0)
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
          Padding(
              padding: const EdgeInsetsDirectional.only(start: 12),
              child: Text('${model.name}' , maxLines: 2 , overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: TextStyle(fontSize: 13),)
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 12),
                child: Text('${model.price} E.G' ,style: TextStyle(color: Colors.deepOrange)),
              ),
              SizedBox(
                width: 5,
              ),
              Spacer(),
              IconButton(
                // Remove padding .
                constraints: BoxConstraints(),
                onPressed: (){}, icon: Icon(Icons.favorite_border_rounded) , iconSize: 13,),
            ],
          ),
          if (model.discount != 0 )
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 12),
              child: Text('${model.oldPrice} E.G' ,style: TextStyle(color: Colors.grey , fontSize: 8.5 , decoration: TextDecoration.lineThrough)),
            ),
        ],
      ),
    ),
  );

  Widget buildCategoryItem(DataModel? categories , context )=> Card(
  margin: EdgeInsets.zero,
  clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.white70, width: 1),
      borderRadius: BorderRadius.circular(20),
    ),
  child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(image: NetworkImage('${categories!.image}'),
          height: 100,
          width: 100,
          fit: BoxFit.cover,),
        Container(
          width: 100.0,
          color: Colors.black.withOpacity(.7),
          child: Text(
            '${categories.name}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),

      ],
    ),
  );

}
