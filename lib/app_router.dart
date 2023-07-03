import 'package:flutter/material.dart';

import 'constants/strings.dart';
import 'presentation/screen/course_path.dart';

class AppRouter {
  Route? generateRout(RouteSettings settings) {
    switch (settings.name) {
      case path_screen:
        return MaterialPageRoute(builder: (_) => const course_path());

      // default:
    }
    return null;
  }
}
