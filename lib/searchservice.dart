import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchFlowerByName(String FlowerName){
    return Firestore.instance.collection("FlowerDetail")
        .where('searchKey', isEqualTo: FlowerName.substring(0,1).toUpperCase())
        .getDocuments();
  }
}