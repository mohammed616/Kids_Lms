import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/presentation/screen/on_boarding_screen.dart';
import 'package:kids_lms_project/presentation/widgets/Text1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override

  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_)=>OnBoardingScreen(),

      ));
    });

  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }



  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [MyAppColors.verylightBlue,MyAppColors.purple],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset( 'assets/images/splash.png'),
            SizedBox(height: 10,),
            Text1(value: 'KIDS LMS', Size: 38),
          ],
        ),
      ),
    );
  }
}
