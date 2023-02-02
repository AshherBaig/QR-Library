import 'package:f_y_p/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Utils/utilities.dart';
import '../../components/constants.dart';
import '../../components/round_button.dart';


class VerifyScreen extends StatefulWidget {
  final String verificationId;
  const VerifyScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool loading = false;
  final VerificationCodeController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Verify"),
        // automaticallyImplyLeading: false,
        backgroundColor: darkColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: VerificationCodeController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone_android),
                  // helperText: "e.g +92 123 4567890",
                  hintText: "6 digits code"
              ),
            ),
            SizedBox(height: 30,),
            RoundButton(
              loading: loading,
              title: "Login",
              onTap: () async{
                setState(() {
                  loading = true;
                });

              final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: VerificationCodeController.text,
              );

              try{
                await auth.signInWithCredential(credential);

                Navigator.push(context,
                MaterialPageRoute(builder: (context)=> HomePage()));


              }catch(e){
                setState(() {
                  loading = false;
                });
                utils().toastMessage(e.toString());
              }
              },
            ),

          ],
        ),
      ),
    );
  }
}
