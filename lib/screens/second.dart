import 'dart:convert';

import 'package:f_y_p/Utils/utilities.dart';
import 'package:f_y_p/components/constants.dart';
import 'package:f_y_p/screens/menu_screens/students_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool camState = false;
  final ref = FirebaseDatabase.instance.ref("books");

  qrCallback(String? code) {
    setState(() {
      camState = false;
      _qrInfo = code;
    });
    bool present = false;
    ref.get().then((val){
          val.children.forEach((element) {
            Map<dynamic, dynamic> val = element.value! as Map<dynamic, dynamic>;
            if (val["Book"] == code) {
              present = true;
              return;
            }
          });
          if (present) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        StudentsList(fromScan: true, bookName: code)));
          } else {
            utils().toastMessage("Book not available");
          }
        });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      camState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkColor,
        onPressed: () {
          if (camState == true) {
            setState(() {
              camState = false;
            });
          } else {
            setState(() {
              camState = true;
            });
          }
        },
        child: Icon(Icons.camera),
      ),
      body: camState
          ? Center(
              child: SizedBox(
                height: 1000,
                width: 500,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    qrCallback(code);
                  },
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Code :" + _qrInfo!,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
