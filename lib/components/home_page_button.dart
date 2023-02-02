import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';

class ButtonOne extends StatelessWidget {

  final VoidCallback ontap;
  final String title;
  // final AssetImage icon;
  const ButtonOne({Key? key, required this.ontap, required this.title,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Center(child: FaIcon(FontAwesomeIcons.peopleGroup, size: 70, color: darkColor,)),
          SizedBox(height: 10,),
          Center(child: Text(title, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),)

          ],
        ),
        height: 180,
        width: 145,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: lightColor,
          // border: Border.all(color: darkColor, width: 4)
          // image: DecorationImage(image: icon,
          // scale: 8
          // ),
        ),
      ),
    );
  }
}



class ButtonTwo extends StatelessWidget {
  final VoidCallback ontap;
  final String title;
  const ButtonTwo({Key? key, required this.ontap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
onTap: ontap,
      child: Container(
        height: 130,
        width: 145,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: lightColor,
          // border: Border.all(color: darkColor, width: 4,),
        ),
        child: Column(
          children: [
            SizedBox(height: 18,),
            Center(child: FaIcon(FontAwesomeIcons.list, size: 70, color: darkColor,)),
            SizedBox(height: 5,),
            Center(child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),)

          ],
        ),
      ),
    );
  }
}



class ButtonThree extends StatelessWidget {
  final VoidCallback ontap;
  final String title;
  const ButtonThree({Key? key, required this.ontap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 130,
        width: 145,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: lightColor,
          // border: Border.all(color: darkColor, width: 4,),
        ),
        child: Column(
          children: [
            SizedBox(height: 18,),
            Center(child: FaIcon(FontAwesomeIcons.book, size: 70, color: darkColor,)),
            SizedBox(height: 5,),
            Center(child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),)

          ],
        ),
      ),
    );
  }
}



class ButtonFour extends StatelessWidget {
  final VoidCallback ontap;
  final String title;
  const ButtonFour({Key? key, required this.ontap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 180,
        width: 145,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: lightColor,
          // border: Border.all(color: darkColor, width: 4,),
        ),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Center(child: FaIcon(FontAwesomeIcons.listCheck, size: 70, color: darkColor,)),
            SizedBox(height: 5,),
            Center(child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),)

          ],
        ),
      ),
    );
  }
}