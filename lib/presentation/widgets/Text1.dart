import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';


Text Text1({required String value,required double Size}){
  return Text(
    value,
    style:GoogleFonts.quicksand(fontSize: Size,fontWeight: FontWeight.bold,color: MyAppColors.purple),
  );
}