import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/textform.dart';
import 'package:shop_app/shared/network/cache_helper/cache_helper.dart';
import 'package:shop_app/shared/styles/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel{
  late final String image;
  late final String title;
  late final String body;
  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var BoardController=PageController();

  List<BoardingModel> boarding= [
    BoardingModel(
      title: 'On Board 1 Title',
      image: 'assets/images/onboard_1.jpg',
      body: 'On Board 1 Body',),
    BoardingModel(
      title: 'On Board 2 Title',
      image: 'assets/images/onboard_1.jpg',
      body: 'On Board 2 Body',),
    BoardingModel(
      title: 'On Board 3 Title',
      image: 'assets/images/onboard_1.jpg',
      body: 'On Board 3 Body',),
  ];
  bool isLast=false;
  void submit(){
    CacheHelper.saveData(key:'onBoarding' , value:true ).then((value){
      if(value)
      {
        navigateAndFinish(context,ShopLoginScreen());
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(function:submit, text:'skip'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: ( int index){
                  if(index==boarding.length-1)
                  {
                    setState(() {
                      isLast=true;
                    });
                    print('last');
                  }
                  else{
                    print(' not last');
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                controller: BoardController,
                itemBuilder: (context,index)=>BuildBoardingItem(boarding[index]),
                itemCount: boarding.length,),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(controller: BoardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,

                  ),
                ),
                Spacer(),
                FloatingActionButton(onPressed:()
                {
                  if(isLast==true)
                  {
                    submit();
                  }
                  else{
                    BoardController.nextPage(duration: Duration(
                      milliseconds: 750,
                    ), curve: Curves.fastLinearToSlowEaseIn);
                  }
                },
                  child: Icon(Icons.arrow_forward_ios),)
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget BuildBoardingItem (BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image:AssetImage(
            '${model.image}'
        )),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',

        style: TextStyle(
          fontSize:24.0,

        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',

        style: TextStyle(
          fontSize:14.0,

        ),
      ),
      SizedBox(
        height: 15.0,
      ),

    ],
  );
}
