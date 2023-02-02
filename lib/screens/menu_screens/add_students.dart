import 'package:f_y_p/Utils/utilities.dart';
import 'package:f_y_p/components/round_button.dart';
import 'package:f_y_p/screens/menu_screens/students_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../components/constants.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({Key? key}) : super(key: key);

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  final _formKey = GlobalKey<FormState>();
  final studentsNameController = TextEditingController();
  final rollNumberController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('students');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    studentsNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Add Students",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: darkColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: studentsNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Enter a Name",
                  label: Text("Students"),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "enter name";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: rollNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Enter a Roll no",
                  label: Text("Roll Number"),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "enter roll no";
                  } else {
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
              SizedBox(
                height: 30,
              ),

              RoundButton(
                  title: "Add",
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = false;
                      });

                      bool present = false;
                      databaseRef.get().then((val) {
                        val.children.forEach((element) {
                          Map<dynamic, dynamic> val =
                              element.value! as Map<dynamic, dynamic>;
                          if (val['RollNumber'] == rollNumberController.text) {
                            present = true;
                            return;
                          }
                        });
                        if (!present) {
                          String id =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          databaseRef.child(id).set({
                            'id': id,
                            'Name': studentsNameController.text.toString(),
                            'RollNumber': rollNumberController.text.toString(),
                          }).then((value) {
                            setState(() {
                              loading = false;
                            });
                            utils().toastMessageGreen("Added");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StudentsList()));
                            // Navigator.pop(context);
                          }).onError((error, stackTrace) {
                            setState(() {
                              loading = false;
                            });
                            utils().toastMessage(error.toString());
                          });
                        } else {
                          utils().toastMessage("Roll no is entered already");
                        }
                      });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
