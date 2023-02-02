import 'package:f_y_p/Utils/utilities.dart';
import 'package:f_y_p/screens/auth/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/round_button.dart';


class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
        // automaticallyImplyLeading: false,
        backgroundColor: darkColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            SizedBox(height: 30,),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_android),
                    helperText: "e.g +92 123 4567890",
                    hintText: "Enter phone number"
                  ),
                ),
            SizedBox(height: 30,),
            RoundButton(
              loading: loading,
              title: "Login",
              onTap: (){
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                  phoneNumber: phoneNumberController.text,
                    verificationCompleted: (_){
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e){
                      setState(() {
                        loading = false;
                      });
                    utils().toastMessage(e.toString());
                    },
                    codeSent: (String verificationId, int? token){
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context)=> VerifyScreen(verificationId: verificationId)));
                        setState(() {
                          loading = false;
                        });
                    },
                    codeAutoRetrievalTimeout: (e){
                    utils().toastMessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                    },
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}