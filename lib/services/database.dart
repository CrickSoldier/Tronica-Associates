import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addResidentialPost(data) async {
    FirebaseFirestore.instance
        .collection("Residential")
        .doc()
        .set(data)
        .catchError((e) {
      // ignore: avoid_print
      print(e.toString());
    });
  }

  Future<void> addAnyPost(collection, data) async {
    FirebaseFirestore.instance
        .collection(collection)
        .doc()
        .set(data)
        .catchError((e) {
      // ignore: avoid_print
      print(e.toString());
    });
  }

  Future<void> addCommercialPost(data) async {
    FirebaseFirestore.instance
        .collection("Commercial")
        .doc()
        .set(data)
        .catchError((e) {
      // ignore: avoid_print
      print(e.toString());
    });
  }

  Future<void> addIndustrialPost(data) async {
    FirebaseFirestore.instance
        .collection("Industrial")
        .doc()
        .set(data)
        .catchError((e) {
      // ignore: avoid_print
      print(e.toString());
    });
  }

  Future<dynamic> getResidentialPost() async {
    return FirebaseFirestore.instance.collection("Residential").snapshots();
  }

  Future<dynamic> getIndustrialPost() async {
    return FirebaseFirestore.instance.collection("Industrial").snapshots();
  }

  Future<dynamic> getCommercialPost() async {
    return FirebaseFirestore.instance.collection("Commercial").snapshots();
  }
}
