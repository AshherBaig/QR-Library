import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../second.dart';

class SubmitScreen extends StatelessWidget {
  SubmitScreen({Key? key}) : super(key: key);

  final ref = FirebaseDatabase.instance.ref("SubmitBooks");
  final issueRef = FirebaseDatabase.instance.ref("IssuedBooks");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: darkColor,
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => Second()));
      //     }),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkColor,
        title: const Text('Submit Book'),
      ),
      body: Column(
        children: [
          Expanded(child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index)
          {
            return Card(
              child: ListTile(
                title: Text("Student Name: "+snapshot.child("Name").value.toString()+
                    "\nBook: "+snapshot.child("Book").value.toString(),
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text("\nRoll No: "+ snapshot.child("RollNo").value.toString()
                    + "\nTime: "+snapshot.child("Time").value.toString(),
                    // + "\nIssued time: "+
                    //         issueRef.child("id").child("time").toString(),
                  style: TextStyle(fontWeight: FontWeight.w500),),


              ),
            );
          })),
        ],
      ),
    );
  }

}
