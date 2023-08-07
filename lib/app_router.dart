import 'package:flutter/material.dart';
import 'package:kids_lms_project/presentation/screen/WordGame.dart';
import 'package:kids_lms_project/presentation/screen/login_screen.dart';
import 'package:kids_lms_project/presentation/screen/on_boarding_screen.dart';
import 'package:kids_lms_project/presentation/screen/quiz_answers.dart';
import 'package:kids_lms_project/presentation/screen/quiz_screen.dart';
import 'package:kids_lms_project/presentation/screen/splash_screen.dart';

import 'constants/strings.dart';
import 'presentation/screen/course_path.dart';


class AppRouter {
  Route? generateRout(RouteSettings settings) {
    switch (settings.name) {
      case path_screen:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      // default:
    }
    return null;
  }
}
