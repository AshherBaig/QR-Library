import 'package:f_y_p/Utils/utilities.dart';
import 'package:f_y_p/components/round_button.dart';
import 'package:f_y_p/screens/menu_screens/books_list.dart';
import 'package:f_y_p/screens/menu_screens/students_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../components/constants.dart';

class AddBooks extends StatefulWidget {
  const AddBooks({Key? key}) : super(key: key);

  @override
  State<AddBooks> createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {

  // final studentsNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bookNameController = TextEditingController();
  final authorController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('books');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Add Books", style: TextStyle(fontSize: 22),),
        centerTitle: true,
        backgroundColor: darkColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                controller: bookNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Enter a Book Name",
                  label: Text("Books"),
                ),
                validator: (value){
                  if (value!.isEmpty){
                    return "enter book name";
                  }
                  else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: authorController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Enter a Author Name",
                  label: Text("Author"),
                ),
                validator: (value){
                  if (value!.isEmpty){
                    return "enter author name";
                  }
                  else{
                    return null;
                  }
                },
              ),
              // SizedBox(height: 20,),
              // TextFormField(
              //   controller: depttNameController,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black),
              //     ),
              //     hintText: "Enter a departement",
              //     label: Text("Departement"),
              //   ),
              // ),
              SizedBox(height: 30,),


              RoundButton(title: "Add",
                  loading: loading,
                  onTap: (){
    if(_formKey.currentState!.validate())
      {
    setState(() {
    loading = true;
    });

    String id = DateTime.now().millisecondsSinceEpoch.toString();

    databaseRef.child(id).set({
    'id' : id,
    'Book': bookNameController.text.toString(),
    'Author' : authorController.text.toString(),

    }).then((value){
    setState(() {
    loading = false;
    });
    utils().toastMessageGreen("Added");
    Navigator.push(context, MaterialPageRoute(builder: (context)=> BooksList()));
    // Navigator.pop(context);
    }).onError((error, stackTrace){
    setState(() {
    loading = false;
    });
    utils().toastMessage(error.toString());
    });
    }  })
            ],
          ),
        ),
      ),
    );
  }
}
