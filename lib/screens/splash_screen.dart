import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:f_y_p/firebase_services/splash_services.dart';
import 'package:f_y_p/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashScreen = SplashServices();
@override
void initState()
{
super.initState();
splashScreen.isLogin(context);
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
              splash: Image.asset("images/logo.jpg",),
              splashTransition: SplashTransition.sizeTransition,
              // animationDuration: Duration(seconds: 4),
              curve: Curves.bounceInOut,
              nextScreen: SplashScreen(),
            duration: 2500,
            splashIconSize: 150,
            // backgroundColor: Color(0xff263a7a),
          ),
    );
  }
}




// MaterialApp(
// home: Scaffold(
// body: Center(
// child: Text("Library App", style: TextStyle(fontSize: 30),),
// ),
// ),
// )