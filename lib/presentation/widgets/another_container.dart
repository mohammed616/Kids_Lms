import 'package:flutter/material.dart';

// ignore: must_be_immutable
class container2_decoration_ extends StatelessWidget {
  double border_radius_val;
  double container_height;
  Color color_1;
  Color color_2;
  Color color_3;

  container2_decoration_({
    required this.border_radius_val,
    required this.container_height,
    required this.color_1,
    required this.color_2,
    required this.color_3,
  });

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _another_decorationContainer(double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: color_1,
          ),
        ),
        _smallContainer(color_2, 40, 20),
        Positioned(
          top: -30,
          right: -10,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: color_1,
            child: CircleAvatar(radius: 40, backgroundColor: color_3),
          ),
        ),
      ],
    );
  }

  Positioned _smallContainer(Color primaryColor, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primaryColor.withAlpha(255),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _another_decorationContainer(-110, -85),
        ],
      ),
    );
  }
}
