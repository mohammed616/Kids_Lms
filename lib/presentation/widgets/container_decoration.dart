import 'package:flutter/material.dart';

// ignore: must_be_immutable
class container_decoration_ extends StatelessWidget {
  double border_radius_val;
  double container_height;
  double container_width;
  Color container_color;
  Color color_1;
  Color color_2;
  Color color_3;

  container_decoration_({
    Key? key,
    required this.border_radius_val,
    required this.container_height,
    required this.container_width,
    required this.container_color,
    required this.color_1,
    required this.color_2,
    required this.color_3,
  }) : super(key: key);

  Widget main_container() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(border_radius_val),
      child: Container(
          height: container_height,
          width: container_width,
          decoration: BoxDecoration(
            color: container_color,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -140,
                  child: _circularContainer(container_width * .6, color_1)),
              Positioned(
                  top: -60,
                  left: -70,
                  child: _circularContainer(container_width * .3, color_2)),
              Positioned(
                  top: -220,
                  right: -50,
                  child: _circularContainer(
                      container_width * .6, Colors.transparent,
                      borderColor: Colors.white38)),
            ],
          )),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          main_container(),
        ],
      ),
    );
  }
}
