import 'package:f_y_p/Utils/utilities.dart';
import 'package:f_y_p/screens/menu_screens/books_list.dart';
import 'package:f_y_p/screens/auth/login_screen.dart';
import 'package:f_y_p/screens/menu_screens/issue_screen.dart';
import 'package:f_y_p/screens/menu_screens/students_list.dart';
import 'package:f_y_p/screens/profile_screen.dart';
import 'package:f_y_p/screens/menu_screens/submit_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:f_y_p/components/constants.dart';

class SideBarDrawer extends StatefulWidget {
  const SideBarDrawer({Key? key}) : super(key: key);

  @override
  State<SideBarDrawer> createState() => _SideBarDrawerState();
}

class _SideBarDrawerState extends State<SideBarDrawer> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  final List drawerMenuListname = [
    {
      "leading": FaIcon(FontAwesomeIcons.peopleGroup, color: darkColor,),
      "title": "Students List",
      "trailing": Icon(
        Icons.chevron_right,
      ),
      "action_id": 1,
    },
    {
      "leading": FaIcon(FontAwesomeIcons.book, color: darkColor,),
      "title": "All Books",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 2,
    },
    {
      "leading": FaIcon(FontAwesomeIcons.list, color: darkColor,),
      "title": "Issued Book",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 3,
    },
    {
      "leading": FaIcon(FontAwesomeIcons.listCheck, color: darkColor,),
      "title": "Submited Books",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 4,
    },
    {
      "leading": Icon(
        Icons.exit_to_app,
        color: Color(0xff263a7a),
      ),
      "title": "Log Out",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 5,
    },
  ];

  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 250,
        child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              ListTile(
                onTap: (){
                  Navigator.pop(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage("images/logo.jpg"),
                ),
                title: Text(
                  "QrCode Library",
                  style: TextStyle(fontSize: 18,
                    color: darkColor,
                  ),
                ),
                // subtitle: Text(
                //   "Staff ID",
                //   style: TextStyle(
                //     color: Colors.black,
                //   ),
                // ),
              ),
              SizedBox(
                height: 1,
              ),
              ...drawerMenuListname.map((sideMenuData) {
                return ListTile(
                  leading: sideMenuData['leading'],
                  title: Text(
                    sideMenuData['title'],
                    style: TextStyle(color: darkColor,
                    ),
                  ),
                  trailing: sideMenuData['trailing'],
                  onTap: () {
                    Navigator.pop(context);
                    if (sideMenuData['action_id'] == 1) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StudentsList(),
                        ),
                      );
                    }
                    else if (sideMenuData['action_id'] == 2) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BooksList(),
                        ),
                      );
                    }
                    else if (sideMenuData['action_id'] == 3) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => IssueBookScreen(),
                        ),
                      );
                    }
                    else if (sideMenuData['action_id'] == 4) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SubmitScreen(),
                        ),
                      );
                    }

                    else if (sideMenuData['action_id'] == 5){
                      auth.signOut().then((value){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      }).onError((error, stackTrace){
                        utils().toastMessage(error.toString());
                      });
                    }
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
