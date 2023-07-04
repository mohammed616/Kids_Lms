import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/presentation/widgets/Text1.dart';

import '../widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isHidden=true;

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
                 // SizedBox(height: 20,),
                 Expanded(
                   flex: 3,
                   child: Column(
                     children: [
                       Text1(value: 'LMS', Size: 64),
                       Image.asset('assets/images/book.png')
                     ],
                   ),
                 ),
                 Expanded(
                   flex:2,
                   child: Column(
                     children: [

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
                             return 'Password must not be empty';
                           }
                         },
                         controller: password,
                         label: 'Password',
                         prefixIcon: Icons.lock,
                         keyboardType: TextInputType.visiblePassword,
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
                             // cubit.userLogin(
                             //     email: emailController.text,
                             //     password: passwordController.text
                             // );
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
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             "If you don't have an account,\n contact the supervisors.",
                             style: GoogleFonts.quicksand(
                                 fontWeight: FontWeight.bold,
                                 color: MyAppColors.purple,

                             ),
                             )
                         ],
                       ),
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


