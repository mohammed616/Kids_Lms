import 'package:flutter/material.dart';

// ignore: must_be_immutable
class main_button extends StatelessWidget {
  Function function_;
  double height_;
  double width_;
  double margin_;
  Color color_1;
  Color color_2;
  Color textColor;
  String text;

  main_button({
    Key? key,
    required this.function_,
    required this.height_,
    required this.width_,
    required this.margin_,
    required this.color_1,
    required this.color_2,
    required this.textColor,
    required this.text,
  }) : super(key: key);
  Widget main_Button_dec() {
    return Container(
      height: height_,
      margin: EdgeInsets.all(margin_),
      child: InkWell(
        onTap: () => function_,
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color_1, color_2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(28.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 280.0, minHeight: 52.0),
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          main_Button_dec(),
        ],
      ),
    );
  }
}
