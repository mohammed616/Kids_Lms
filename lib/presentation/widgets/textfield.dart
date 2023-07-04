import 'package:flutter/material.dart';
import 'package:kids_lms_project/constants/colors.dart';

Widget registerTextFormField({
  required FormFieldValidator validator,
  required TextEditingController controller,
  bool isHidden = true,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  Function? function,
  required TextInputType keyboardType
}){
  return TextFormField(
    style: TextStyle(color: MyAppColors.purple),
    keyboardType: keyboardType,
    validator: validator,
    controller: controller,
    obscureText: isHidden,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontSize: 16.0,color: MyAppColors.magenta),
      prefixIcon: Icon( prefixIcon,color: MyAppColors.magenta,),
      suffixIcon:suffixIcon!=null? IconButton(onPressed: (){
        function!();
      }, icon: Icon(suffixIcon,color: MyAppColors.magenta,)):null,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
            color: MyAppColors.magenta,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
            color: MyAppColors.magenta
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
            color: Colors.red
        ),
      ),
    ),
  );
}