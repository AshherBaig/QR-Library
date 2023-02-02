import 'package:f_y_p/Utils/utilities.dart';
import 'package:f_y_p/components/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final auth = FirebaseAuth.instance;
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Frogot Password", style: TextStyle(fontSize: 22),),
            centerTitle: true,
            backgroundColor: darkColor,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 100,),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
                SizedBox(height: 30,),

              RoundButton(title: "Forgot",
                  onTap: (){
                auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                  utils().toastMessageGreen("We have send you email to recover password, please check email");
                }).onError((error, stackTrace){
                  utils().toastMessage(error.toString());
                });
                  }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
