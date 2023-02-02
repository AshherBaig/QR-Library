import 'package:f_y_p/Utils/utilities.dart';
import 'package:f_y_p/screens/second.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../components/constants.dart';

class IssueBookScreen extends StatelessWidget {
  IssueBookScreen({Key? key}) : super(key: key);


  // final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("IssuedBooks");
  final refSubmit = FirebaseDatabase.instance.ref("SubmitBooks");

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
        title: const Text('Issued Books'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index)
                {
                  return Card(
                    child: ListTile(
                      title: Text("Student Name: "+snapshot.child("name").value.toString()+
                          "\nBook: "+snapshot.child("bookName").value.toString(),
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text("\nRoll No: "+ snapshot.child("rollNo").value.toString()
                      + "\nTime: "+snapshot.child("time").value.toString(),
                        style: TextStyle(fontWeight: FontWeight.w500),),
                      trailing: PopupMenuButton(
                      icon : Icon(Icons.subdirectory_arrow_right),
                      itemBuilder: (context)=> [
                        PopupMenuItem(
                            child: Text("Submit"),
                          onTap: (){
                              // Navigator.of(context).pop();
                            ref.child(snapshot.child("id").value.toString()).remove();
                              String id = DateTime.now().millisecondsSinceEpoch.toString();
                              refSubmit.child(id).set({
                                "id": id,
                                "Name": snapshot.child("name").value.toString(),
                                "RollNo": snapshot.child("rollNo").value.toString(),
                                "Book" : snapshot.child("bookName").value.toString(),
                                "Time" : DateTime.now().toString(),

                              }).then((value){
                                utils().toastMessageGreen("Book is Submited");
                              }).onError((error, stackTrace){
                                utils().toastMessage(error.toString());
                              });
                          },
                        )
                      ]
                      ),
                  ),
                  );
                }
            ),
          )
        ],
      )
    );
  }
}
