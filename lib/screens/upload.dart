import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tronicassociates/screens/home.dart';
import 'package:tronicassociates/services/database.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String? _chosenValueCategory;
  String? _chosenValueTag;
  String? imageUrl;
  DatabaseMethods databaseMethods = DatabaseMethods();

  TextEditingController sectorController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  static var list = [
    "assets/images/image1.jpg",
    "assets/images/image2.jpg",
    "assets/images/image3.jpg",
    "assets/images/image4.jpg",
    "assets/images/image5.jpg",
    "assets/images/image6.jpg",
    "assets/images/image7.jpg",
    "assets/images/image8.jpg",
    "assets/images/image9.jpg"
  ];

  var randomItem = (list.toList()..shuffle()).first;

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = sectorController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  addData() {
    Map<String, dynamic> data = {
      "category": _chosenValueCategory.toString(),
      "tag": _chosenValueTag.toString(),
      "sector": sectorController.text,
      "area": areaController.text,
      "image": imageUrl.toString(),
    };

    databaseMethods.addAnyPost(_chosenValueCategory.toString(), data);
    // CollectionReference postRefrence =
    //     FirebaseFirestore.instance.collection("Residential");
    // postRefrence.doc().set(data);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));

    print("function worksss");
    print(randomItem);
  }

  uploadImage(category, sector, area) async {
    final firebaseStorage = FirebaseStorage.instance;
    final imagePicker = ImagePicker();
    // PickedFile? image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);
      var file = File(image!.path);

      // ignore: unnecessary_null_comparison
      if (image != null) {
        //Upload to Firebase
        var snapshot = await firebaseStorage
            .ref()
            .child('$category/$sector/$area/')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Post"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  const Text("Select Category"),
                  const Spacer(),
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    value: _chosenValueCategory,
                    //elevation: 5,
                    style: const TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Industrial',
                      'Commercial',
                      'Residential',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: const Text(
                      "Category",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _chosenValueCategory = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Select Tag"),
                  const Spacer(),
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    value: _chosenValueTag,
                    //elevation: 5,
                    style: const TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'To Sell',
                      'To Rent',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: const Text(
                      "Tag",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _chosenValueTag = value;
                      });
                    },
                    // onChanged: (String value) {
                    //   setState(() {
                    //     _chosenValue = value;
                    //   });
                    // },
                  ),
                ],
              ),
              TextFormField(
                controller: sectorController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.security_sharp),
                  hintText: 'Enter Sector',
                  labelText: 'Enter Sector',
                  errorText: _errorText,
                ),
              ),
              TextFormField(
                controller: areaController,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.area_chart),
                  hintText: 'Enter Area',
                  labelText: 'Enter Area',
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        spreadRadius: 2,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: (imageUrl != null)
                      ? Image.network(imageUrl!)
                      : Image.network('https://i.imgur.com/sUFH1Aq.png')),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: const Text("Upload Image",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                onPressed: () {
                  uploadImage(_chosenValueCategory.toString(),
                      sectorController.text, areaController.text);
                },
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          elevation: 10, // foreground
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10)),
                      onPressed: addData,
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
