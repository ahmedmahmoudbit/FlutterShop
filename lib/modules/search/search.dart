import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('search'),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  defaultFormField(
                      controller: textController,
                      type: TextInputType.text,
                      validate: (String? value){
                        if (value!.isEmpty) {
                          return 'Please enter your product name';
                        }
                        return null;
                      },
                      label: 'search',
                      onSubmit: (String text){
                       ShopCubit.get(context).getSearch(text);
                      },
                      prefix: Icons.search_rounded),
                  SizedBox(height: 10,),
                  if (state is SearchLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(height: 10,),
                  if (state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).searchModel!.data!.data[index], context , isOldPrice: false),
                        separatorBuilder: (context, index) => SizedBox(height: 5,),
                        itemCount: ShopCubit.get(context).searchModel!.data!.data.length),

                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
