import 'package:flutter/material.dart';
import 'package:shop_app/models/homeModel.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({Key? key , required this.model}) : super(key: key);
  ProductsModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Center(child: Image(image: NetworkImage('${model.image}'), height: 180,width: double.infinity,)),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${model.name}' , maxLines: 2 , overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17 , color: Colors.redAccent),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
        if (model.description != null)
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                child:
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('${model.description}', textAlign: TextAlign.start, style: TextStyle(fontSize: 13),),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
