



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_lms_project/presentation/screen/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image, required this.title, required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(image: 'assets/images/onlin.png',
        title: 'Learning',
        body: 'Increase your knowledge and develop your talents.'),
    BoardingModel(image: 'assets/images/education.png',
        title: 'Go on',
        body: 'Be diligent and strive for the best.'),
    BoardingModel(image: 'assets/images/game.png',
        title: 'Enjoy',
        body: 'Enjoy playing educational games.')
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.verylightBlue,
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(onPressed: (){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  LoginScreen()),(Route<dynamic>route)=> false,
            );
          }, child: Text('SKIP',style: GoogleFonts.quicksand(fontSize: 20,color: MyAppColors.magenta),),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index){
                  if (index==boarding.length  -1){
                    setState(() {
                      isLast=true;
                    });
                    print('last');
                  }
                  else{

                    setState(() {
                      isLast=false;
                    });
                    print('not last');
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController, count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.white,
                    dotHeight: 10,
                    activeDotColor: MyAppColors.magenta,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(

                  backgroundColor:MyAppColors.magenta,
                  onPressed: () {
                    if (isLast) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) =>  LoginScreen()),(Route<dynamic>route)=> false,
                      );
                    } else {
                      boardController.nextPage(duration: Duration(
                        microseconds: 750,
                      ), curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
                image: AssetImage('${model.image}'),
              )),
          Text('${model.title}', style: GoogleFonts.quicksand(
            fontSize: 24.0,
            color: MyAppColors.magenta,
          ),),
          SizedBox(height: 15,),
          Text('${model.body}', style: GoogleFonts.quicksand(
              fontSize: 14.0,
              color: MyAppColors.purple,
          ),),
          SizedBox(height: 15,),
        ],
      );
}
