// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

// ignore: camel_case_types
class buttons_dec extends StatelessWidget {
  String text;
  Color textColor;
  double fontsize_;
  double height_;
  double width_;

  buttons_dec({
    Key? key,
    required this.text,
    required this.textColor,
    required this.fontsize_,
    required this.height_,
    required this.width_,
  }) : super(key: key);
  Widget _chip(String text, Color textColor,
      {required double height, required double w}) {
    return Container(
      width: width_,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: textColor.withAlpha(50),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: fontsize_),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_chip(text, textColor, height: height_, w: width_)],
      ),
    );
  }
}
