import 'package:f_y_p/Utils/utilities.dart';
import 'package:f_y_p/screens/auth/login_screen.dart';
import 'package:f_y_p/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();



  void signup(){
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value){
          utils().toastMessageGreen("Your acount has been created");
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
      setState(() {
        loading = false;
      });

    }).onError((error, stackTrace){
      setState(() {
        loading = false;
      });
      utils().toastMessage(error.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        // backgroundColor: Color(0xffffbf80),
        // backgroundColor: Color(0xffffd9b3),
        appBar: AppBar(
          title: Text("Sign Up", style: TextStyle(fontSize: 22),),
          centerTitle: true,
          backgroundColor: darkColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 100, 40, 0),
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
                      title: "Sign up",
                      onTap: (){
                        if(_formKey.currentState!.validate())
                        {
                          signup();
                        }
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                      },),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=> LoginScreen()));
                            },
                            child: Text("Login"))
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}











// ElevatedButton(
// style: ElevatedButton.styleFrom(
// primary: Color(0xffff9933),
// minimumSize: Size(200, 50),
// shadowColor: Colors.black,
// ),
//
// onPressed: (){
// _auth.createUserWithEmailAndPassword(
// email: emailController.text,
// password: passwordController.text,
//
// ).then((value){
// print("sign success");
// Navigator.of(context).push(
// MaterialPageRoute(
// builder: (context) => HomePage(),
// ),
// );
// }
// ).onError((error, stackTrace)
// {
// print(error.toString());
// });
// },
// child: Text("Sign Up"))