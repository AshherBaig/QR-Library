import 'dart:async';
import 'package:f_y_p/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:f_y_p/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashServices{

  isLogin(BuildContext context){

    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user!= null)
      {
        Timer(Duration(seconds: 3),
                ()=> Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => HomePage()
                )));
      }
       else{
            Timer(Duration(seconds: 3),
            ()=> Navigator.push(context,
            MaterialPageRoute(
            builder: (context) => LoginScreen()
            )));
            }

  }
}