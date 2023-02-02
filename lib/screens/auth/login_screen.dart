import 'package:f_y_p/Utils/utilities.dart';
import 'package:f_y_p/components/constants.dart';
import 'package:f_y_p/components/round_button.dart';
import 'package:f_y_p/screens/auth/forgot_password.dart';
import 'package:f_y_p/screens/auth/login_with_phone_number.dart';
import 'package:f_y_p/screens/auth/sign_up.dart';
import 'package:f_y_p/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()
    ).then((value){
      utils().toastMessageGreen(value.user!.email.toString());
      // Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace)
    {
      // debugPrint(error.toString());
      utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Login"),
          automaticallyImplyLeading: false,
          backgroundColor: darkColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TextFormField(
                  controller: emailController,
                  decoration:InputDecoration(
                      hintText: "Email",
                      // helperText: "enter email e.g john@gmail.com",
                      prefixIcon: Icon(Icons.email),
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(20)
                      // )
                  ),

                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter email';
                    }
                    return null ;
                  },
                ),

                SizedBox(height: 20,),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration:InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(20)
                      ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Enter password';
                    }
                    return null ;
                  },
                  ),

                  SizedBox(height: 30,),

                  RoundButton(
                    loading: loading,
                    title: "Login",
                    onTap: (){
                          if(_formKey.currentState!.validate())
                            {
                              login();
                            }
                    },),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text("Don't have an account?"),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> ForgotPassword()));
                        },
                        child: Text("Forgot Password?"))
                  ],
                ),
                SizedBox(height: 20,),

                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> SignUpScreen()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: darkColor,
                        width: 1,
                      )
                    ),
                    child: Center(
                      child: Text("Sign Up"),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
