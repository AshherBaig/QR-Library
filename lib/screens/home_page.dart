// import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:f_y_p/components/constants.dart';
import 'package:f_y_p/components/home_page_button.dart';
import 'package:f_y_p/screens/menu_screens/books_list.dart';
import 'package:f_y_p/screens/menu_screens/issue_screen.dart';
// import 'package:f_y_p/screens/menu_screens/add_students.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:f_y_p/screens/menu_screens/students_list.dart';
import 'package:f_y_p/screens/menu_screens/submit_screen.dart';
import 'package:f_y_p/screens/qr_home.dart';
import 'package:f_y_p/screens/sidebar_screen.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
        // debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            // backgroundColor: darkColor,
            appBar: AppBar(
              title: Text("Home", style: TextStyle(fontSize: 22),),
              centerTitle: true,
              backgroundColor: darkColor,
            ),
            drawer: SideBarDrawer(),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bgimg.jpg"),
                fit: BoxFit.fitHeight,
                )
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                CarouselSlider(
                    items:[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 130,
                        width: 300,
                        decoration: BoxDecoration(
                            // border: Border.all(width: 1,color: lightColor),
                            borderRadius: BorderRadius.circular(20),
// color: Colors.white,
                            image: DecorationImage(image: AssetImage("images/book.jpg"),
                              fit: BoxFit.cover,)
                        ),

                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 130,
                        width: 300,
                        decoration: BoxDecoration(
                            // border: Border.all(width: 1,color: lightColor),
                            borderRadius: BorderRadius.circular(20),
// color: Colors.white,
                            image: DecorationImage(image: AssetImage("images/book1.jpg"),
                              fit: BoxFit.cover,)
                        ),

                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 130,
                        width: 300,
                        decoration: BoxDecoration(
                            // border: Border.all(width: 1,color: lightColor),
                            borderRadius: BorderRadius.circular(20),
// color: Colors.white,
                            image: DecorationImage(image: AssetImage("images/book2.jpg"),
                              fit: BoxFit.cover,)
                        ),

                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 130,
                        width: 300,
                        decoration: BoxDecoration(
                            // border: Border.all(width: 1,color: lightColor),
                            borderRadius: BorderRadius.circular(20),
// color: Colors.white,
                            image: DecorationImage(image: AssetImage("images/book3.jpg"),
                              fit: BoxFit.cover,)
                        ),

                      ),
                    ],
                    options: CarouselOptions(
                      height: 150,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(seconds: 2),

                    )
                ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ButtonOne(
                                // icon: AssetImage("images/students.png"),
                                  title: "Students \n List",
                                  ontap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> StudentsList()));
                              })
                            ),
                            ButtonTwo(
                                title: "Issued Books",
                            ontap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> IssueBookScreen()));
                            },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ButtonThree(
                                  title: "All Books",
                              ontap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> BooksList()));
                              },
                              ),
                            ),
                            ButtonFour(
                              // icon: AssetImage("images/books.png"),
                              title: "Submited \n Books",
                                ontap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SubmitScreen()));
                            }),


                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20,),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            backgroundColor: darkColor,
                              child: Icon(
                                  Icons.qr_code,
                              ),
                              // shape: CircleBorder(side: BorderSide(color: lightColor)),

                              onPressed: (){
                              Navigator.pop(context);
                              Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) => Home(),
                              ));
                              },
                              )
                        ],
                      ),
                    ],
                  )
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}



// InkWell(
// splashColor: Colors.white,
// onTap: (){
// // Navigator.pop(context);
// Navigator.of(context).push(
// MaterialPageRoute(
// builder: (context) => Home(),
// ),
// );
//
// },
// child: Container(
// child: Center(child: Text("QR Code")),
// margin: EdgeInsets.only(top: 20),
// height: 90,
// width: 300,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20),
// color: lightColor,
// ),
// ),
// ),



// Container(
// margin: EdgeInsets.only(top: 20),
// height: 130,
// width: 300,
// decoration: BoxDecoration(
// border: Border.all(width: 1,color: lightColor),
// borderRadius: BorderRadius.circular(20),
// // color: Colors.white,
// image: DecorationImage(image: AssetImage("images/book.jpg"),
// fit: BoxFit.cover,)
// ),
//
// ),