import 'package:f_y_p/Utils/utilities.dart';
import 'package:f_y_p/screens/home_page.dart';
import 'package:f_y_p/screens/menu_screens/add_books.dart';
import 'package:f_y_p/screens/menu_screens/add_students.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import '../../components/constants.dart';

class BooksList extends StatefulWidget {
  const BooksList({Key? key}) : super(key: key);

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  final editController = TextEditingController();
  final searchFilterController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("books");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: darkColor,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddBooks()));
            }),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage())),
          ),
          title: Text(
            "Books",
            style: TextStyle(fontSize: 22),
          ),
          centerTitle: true,
          backgroundColor: darkColor,
        ),
        body: Column(
          children: [
            SizedBox(
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
                    final name = snapshot.child("Book").value.toString();
                    final id = snapshot.child("id").value.toString();


                    if (searchFilterController.text.isEmpty) {
                      return ListTile(
                        title: Text(snapshot.child("Book").value.toString()),
                        subtitle: Text(snapshot.child("Author").value.toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text("Edit"),
                                  onTap: (){
                                    Navigator.pop(context);
                                    showMyDialog(name, snapshot.child("RollNumber").value.toString(), id);

                                  },
                                )),
                            PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text("Delete"),
                                  onTap: (){
                                    Navigator.pop(context);
                                    ref.child(snapshot.child("id").value.toString()).remove().then((value) {
                                      utils().toastMessageGreen("Book is deleted");
                                    }).onError((error, stackTrace) {
                                      utils().toastMessage(error.toString());
                                    });
                                  },
                                )
                            ),
                          ],
                        ),
                      );
                    } else if (name
                        .toLowerCase()
                        .contains(searchFilterController.text.toLowerCase())) {
                      return ListTile(
                        title: Text(snapshot.child("Book").value.toString()),
                        subtitle:
                        Text(snapshot.child("Author").value.toString()),
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



  Future<void> showMyDialog(String title, String rollNo, String id){
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                controller: editController,
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel")),
              TextButton(onPressed: (){
                Navigator.pop(context);
                ref.child(id).update({
                  "Book" : editController.text.toString()
                }).then((value) {
                  utils().toastMessageGreen("Updated");
                }).onError((error, stackTrace){
                  utils().toastMessage(error.toString());
                });
              }, child: Text("Update"))
            ],
          );
        });
  }
}
