import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  addData() {
    Map<String, dynamic> data = {
      "category": _chosenValueCategory.toString(),
      "tag": _chosenValueTag.toString(),
      "sector": sectorController.text,
      "area": areaController.text,
      "image": randomItem.toString(),
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
                decoration: const InputDecoration(
                  icon: const Icon(Icons.security_sharp),
                  hintText: 'Enter Sector',
                  labelText: 'Enter Sector',
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
              const SizedBox(
                height: 100,
              ),
              Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: TextButton(
                        onPressed: addData,
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
