// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/SharedPreferences.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String? image;
  final String? title;
  final String? body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});

}

class OnBoardingScreen extends StatefulWidget {
   OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(image:'assets/images/onboarding1.jpg',
        title: 'Screen One',
        body: 'Shop app is first Flutter App with GC.'),
    BoardingModel(image:'assets/images/onboarding2.png',
        title: 'Screen Two',
        body: 'Shop app is Second Flutter App with GC.'),
    BoardingModel(image:'assets/images/onboarding3.png',
        title: 'Screen Three',
        body: 'Shop app is third Flutter App with GC.'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('onboarding' , style: TextStyle(fontFamily: 'Jannah'),),
        centerTitle: true,
        actions: [
          TextButton(onPressed: ()=> skip(), child: Text('Skip' , style: TextStyle(color: colorDefault),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context , index)=> buildBordingItem(boarding[index]),
                itemCount: boarding.length,
                controller: pageController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length -1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 30,),
            Row(children: [
              SmoothPageIndicator(controller: pageController,
                  count: boarding.length,
              effect: ExpandingDotsEffect(
                dotColor: Colors.grey,
                dotWidth: 10,
                spacing: 5,
                expansionFactor: 5,
                dotHeight: 10,
                activeDotColor:colorDefault,
              ),),
              Spacer(),
              FloatingActionButton(onPressed: (){
                if (isLast) {
                  skip();
                }else {
                  pageController.nextPage(
                    duration: Duration(
                      milliseconds: 750,
                    ),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                }
              } ,
                child: Icon(Icons.arrow_forward_ios , color: Colors.white,),),
            ],)
          ],
        ),
      ),
    );
  }

  Widget buildBordingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}') ,fit: BoxFit.fitHeight, width: double.infinity,)),
      SizedBox(height: 30,),
      Text('${model.title}' , style: TextStyle(fontSize: 35)),
      SizedBox(height: 10,),
      Text('${model.body}' , style: TextStyle(fontSize: 18),),
    ],
  );

  void skip() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateFinish(context , LoginScreen());
      }
    });

  }

}
