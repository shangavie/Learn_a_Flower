import 'package:cloud_firestore/cloud_firestore.dart';

class Flower{
  String fname , description , furl , sunlight , blooms , soil ;
  DocumentReference reference;

  Flower({this.fname, this.description, this.furl, this.sunlight, this.blooms, this.soil});

  Flower.fromMap(Map<String, dynamic> map, {this.reference}){
    fname=map["Name"];
    description=map["Description"];
    furl=map["Url"];
    sunlight=map["Sunlight"];
    blooms=map["Blooms"];
    soil=map["Soil"];
  }

  Flower.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
  toJson() {
    return {'Name': fname, 'Description':description, 'Url':furl, 'Sunlight':sunlight, 'Blooms':blooms, 'Soil':soil};

  }
}