import 'dart:io';
import 'package:f_y_p/Utils/utilities.dart';
import 'package:f_y_p/components/constants.dart';
import 'package:f_y_p/components/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;



  final picker = ImagePicker();
  final double coverHeight = 280;
  final double profileHeight = 144;

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final refProfile = FirebaseDatabase.instance.ref("profile");


  Future ImageGetGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No file selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkColor,
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildTop(),
            Text(
              "Ashher Baig",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              "Library Incharge",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.black12,
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "ABOUT ME",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // color: Colors.black12,
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "We are looking out for a Flutter Developer who will be running and designing product application features across various cross platform devices. Just like Lego boxes that fit on top of one another, we are looking out for someone who has experience using Flutter widgets that can be plugged together, customized and deployed anywhere. Someone who is passionate about code writing, solving technical errors and taking up full ownership of app development.",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          "images/book.jpg",
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );
  Widget buildProfileImage() => CircleAvatar(

        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        child: Padding(
          padding: EdgeInsets.only(right: 24, bottom: 20),
          child: IconButton(
              onPressed: ()async{
                ImageGetGallery();
                firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref("/profile");
                firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

                if(_image != null) {
                  await Future.value(uploadTask);
                  var newUrl = ref.getDownloadURL();
                  String id = DateTime
                      .now()
                      .millisecondsSinceEpoch
                      .toString();
                  refProfile.child(id).set({
                    "id": id,
                    "url": newUrl
                  });
                }
                else{
                  utils().toastMessage("error");
                }
                utils().toastMessageGreen("Uploaded");
              },
            // _image != null ? Image.file(_image!.absolute) :
              icon: Icon(
                Icons.image,
                size: 60,
              )),
        ),
        // backgroundImage: AssetImage('images/photo.jpg'),
      );
  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(top: top, 
            child: buildProfileImage()
        ),
       
      ],
    );
  }
}
