import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/presentation/screen/WordGame.dart';
import 'package:kids_lms_project/presentation/screen/quiz_answers.dart';
import 'package:kids_lms_project/presentation/widgets/Text1.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController AccountOwner = TextEditingController();

  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isHidden=true;
  String? errorMessage;
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        errorMessage = null;
      });
      try {
        var response = await http.post(
          Uri.parse('http://192.168.1.8:8000/api/add_info_student'),
          body: {
            'email': email.text,
            'owner': AccountOwner.text,
            'password': password.text,
          },
        );

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          String token = data['token'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          print(token);
         // print('Error: ${response.statusCode}');
          //print('Error Message: ${response.body}');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuizAnswers()),
          );
        } else {
          print('Error1: ${response.statusCode.toString()}');
          print('Error Message1: ${response.body.toString()}');
          throw  Exception("ee").toString();
        }
      } catch (e) {
        setState(() {
          errorMessage = "Verify your password";
        });
        print('Error: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.verylightBlue,
     body:
     SingleChildScrollView(
       child: Container(
         height: MediaQuery.of(context).size.height,
         child: Padding(
           padding: const EdgeInsets.all(20.0),
           child:
           Form(
            key: formKey,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Expanded(
                   flex: 3,
                   child: Column(
                     children: [
                       Text1(value:  'KIDS LMS', Size: 64),
                       AspectRatio(aspectRatio: 11/9,
                       child: Image.asset('assets/images/book.png'))
                     ],
                   ),
                 ),
                 Expanded(
                   flex:3,
                   child: Column(
                     children: [

                       if (errorMessage != null)
                         Text(
                           errorMessage!,
                           style: GoogleFonts.quicksand(color: Colors.red,fontWeight: FontWeight.bold),
                         ),
                           SizedBox(height: 10),
                           registerTextFormField(
                           validator: (value){
                         if(value.isEmpty){
                        return 'Email must not be empty';
                         }
                           },
                           controller: email,
                           label: 'Email',
                           prefixIcon: Icons.email,
                           keyboardType: TextInputType.emailAddress,
                           isHidden:false,
                       ),
                       SizedBox(height: 20,),
                       registerTextFormField(
                         validator: (value){

                           if(value.isEmpty){
                             return 'this field must not be empty';
                           }
                         },
                         controller: AccountOwner,
                         label: 'Account Owner',
                         prefixIcon: Icons.account_circle_outlined,
                         keyboardType: TextInputType.name,
                         isHidden:false,
                       ),

                       SizedBox(height: 20,),
                       registerTextFormField(
                         validator: (value){
                           if(value.isEmpty){
                             return 'Password must not be empty';
                           }
                         },
                         controller: password,
                         label: 'Password',
                         prefixIcon: Icons.lock,
                         keyboardType: TextInputType.number,

                           function: (){
                             setState(() {
                               isHidden=!isHidden;
                             });
                           }
                       ),
                       SizedBox(height: 20,),
                       GestureDetector(
                         onTap: () {
                           if (formKey.currentState!.validate()) {
                             login();
                           }
                         },
                         child: Padding(
                           padding: const EdgeInsets.symmetric(
                               horizontal: 60),
                           child: Container(
                             height: 50,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius
                                   .circular(30),
                               color: MyAppColors.magenta,
                             ),
                             child: Center(
                               child: Text(
                                 'LOGIN',
                                 style:GoogleFonts.quicksand(
                                     color: Colors.white,
                                     fontSize: 18,
                                     fontWeight: FontWeight
                                         .bold),
                                 textAlign: TextAlign.center,
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(
                         height: 20,
                       ),

                       // Row(
                       //   mainAxisAlignment: MainAxisAlignment.center,
                       //   children: [
                       //     Text(
                       //       "If you don't have an account,\n contact the supervisors.",
                       //       style: GoogleFonts.quicksand(
                       //           fontWeight: FontWeight.bold,
                       //           color: MyAppColors.purple,
                       //
                       //       ),
                       //       )
                       //   ],
                       // ),
                    ] ),
           ),
               ],
             ),
           ),
         ),
       ),
     ),

    );
  }
}

// class EmailInput extends StatelessWidget {
//   const EmailInput({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onChanged: (email){},
//       decoration: InputDecoration(
//         labelText: 'Email',
//         labelStyle:GoogleFonts.quicksand(color: MyAppColors.c2) ,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           borderSide: BorderSide(
//             color: Colors.black,
//             width: 2.0,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           borderSide: BorderSide(
//             color: MyAppColors.c2,
//             width: 2.0,
//           ),
//           //
//           // shape: StadiumBorder(),
//         ),
//       ),
//     );
//   }
// }
//
// class PasswordInput extends StatelessWidget {
//   const PasswordInput({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       obscureText: true,
//       onChanged: (password){},
//       decoration: InputDecoration(
//         labelText: 'Password',
//         labelStyle:GoogleFonts.quicksand(color: MyAppColors.magenta) ,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           borderSide: BorderSide(
//             color: Colors.black,
//             width: 2.0,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           borderSide: BorderSide(
//             color: MyAppColors.magenta,
//             width: 2.0,
//           ),
//           //
//           // shape: StadiumBorder(),
//         ),
//       ),
//     );
//   }
// }


