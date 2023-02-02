import 'package:f_y_p/components/constants.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final bool loading;
  final String title;
  final VoidCallback onTap;
  const RoundButton(
      {Key? key,
        required this.title,
        required this.onTap,
      this.loading = false
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: darkColor,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Center(child: loading ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,) : Text(title, style: TextStyle(color: Colors.white),)),
      ),
    );
  }
}





// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: darkColor,
// minimumSize: Size(200, 50),
// shadowColor: Colors.black,
//
// ),
//
// onPressed: (){
// onTap;
// },
// child: Text(title, style: TextStyle(color: Colors.white),)),





