import 'package:f_y_p/Utils/utilities.dart';
import 'package:f_y_p/screens/home_page.dart';
import 'package:f_y_p/screens/menu_screens/add_students.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../../components/constants.dart';

class StudentsList extends StatefulWidget {
  bool? fromScan = false;
  String? bookName;
  StudentsList({Key? key, this.fromScan, this.bookName}) : super(key: key);

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  final editController = TextEditingController();
  final searchFilterController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("students");
  final refIssue = FirebaseDatabase.instance.ref("IssuedBooks");
  bool confirmResponse = false;

  Future<void> issueBook(String studentName, String rollNo) async {
    print("Inside book issue");
    if (widget.fromScan != null &&
        widget.fromScan! &&
        widget.bookName != null) {
      showConfirmDialog(studentName, rollNo);
    } else if (widget.fromScan != null &&
        widget.fromScan! &&
        widget.bookName == null) {
      utils().toastMessageGreen("Please select a book by scanning its QR code");
    }
  }

  showConfirmDialog(String studentName, String rollNo) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Please confirm"),
            content: Text("Are you sure to issue this book"),
            actions: [
              TextButton(
                  onPressed: () {
                    confirmResponse = false;
                    Navigator.of(context).pop();
                  },
                  child: Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    refIssue.child(id).set({
                      "id": id,
                      "name": studentName,
                      "rollNo": rollNo,
                      "bookName": widget.bookName!,
                      "time": DateTime.now().toString()
                    }).then((value) {
                      utils().toastMessageGreen("your book is issue");
                    }).onError((error, stackTrace) {
                      utils().toastMessage(error.toString());
                    });
                    widget.bookName = null;
                  },
                  child: Text("Yes"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: darkColor,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddStudents()));
            }),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage())),
          ),
          title: Text(
            "Students",
            style: TextStyle(fontSize: 22),
          ),
          centerTitle: true,
          backgroundColor: darkColor,
        ),
        body: Column(
          children: [
            (widget.fromScan != null &&
                    widget.fromScan! &&
                    widget.bookName != null)
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Center(
                        child: Text(
                      "Book name: " + widget.bookName!,
                      style:
                          const TextStyle(fontSize: 22, fontFamily: "Cursive"),
                    )),
                  )
                : SizedBox(
                    height: 5,
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                controller: searchFilterController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search",
                ),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  defaultChild: Text("Loading"),
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    final name = snapshot.child("Name").value.toString();
                    final rollNo =
                        snapshot.child("RollNumber").value.toString();
                    final String id = snapshot.child("id").value.toString();

                    if (searchFilterController.text.isEmpty) {
                      return InkWell(
                        onTap: () {
                          issueBook(name, rollNo);
                        },
                        child: ListTile(
                          title: Text(snapshot.child("Name").value.toString()),
                          subtitle: Text(
                              snapshot.child("RollNumber").value.toString()),
                          trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text("Edit"),
                                onTap: () {
                                  Navigator.pop(context);
                                  showMyDialog(
                                      name,
                                      snapshot
                                          .child("RollNumber")
                                          .value
                                          .toString(),
                                      id);
                                },
                              )),
                              PopupMenuItem(
                                  child: ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text("Delete"),
                                      onTap: () {
                                        Navigator.pop(context);
                    ref.child(snapshot.child("id").value.toString()).remove().then((value) {
                    utils().toastMessageGreen("Name is deleted");
                    }).onError((error, stackTrace) {
                    utils().toastMessage(error.toString());

                    }
                    );
                    }
                                      ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else if (name
                        .toLowerCase()
                        .contains(searchFilterController.text.toLowerCase())) {
                      return ListTile(
                        title: Text(snapshot.child("Name").value.toString()),
                        subtitle:
                            Text(snapshot.child("RollNumber").value.toString()),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(String title, String rollNo, String id) {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                controller: editController,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(id).update({
                      "Name": editController.text.toString(),
                      "RollNumber": rollNo
                    }).then((value) {
                      utils().toastMessageGreen("Updated");
                    }).onError((error, stackTrace) {
                      utils().toastMessage(error.toString());
                    });
                  },
                  child: Text("Update"))
            ],
          );
        });
  }
}
