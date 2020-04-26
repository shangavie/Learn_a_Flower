import 'package:cloud_firestore/cloud_firestore.dart';

class Flower{
  String fname , description , furl , sunlight , blooms , soil , detailedUrl, loggedUser, searchkey ;
  DocumentReference reference;

  Flower({this.fname, this.description, this.furl, this.sunlight, this.blooms, this.soil, this.detailedUrl, this.loggedUser, this.searchkey});

  Flower.fromMap(Map<String, dynamic> map, {this.reference}){
    fname=map["Name"];
    description=map["Description"];
    furl=map["Url"];
    sunlight=map["Sunlight"];
    blooms=map["Blooms"];
    soil=map["Soil"];
    detailedUrl=map["DetailedUrl"];
    loggedUser=map["LoggedUser"];
    searchkey=map["searchKey"];
  }

  Flower.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
  toJson() {
    return {'Name': fname, 'Description':description, 'Url':furl, 'Sunlight':sunlight, 'Blooms':blooms, 'Soil':soil, 'DetailedUrl':detailedUrl, 'LoggedUser':loggedUser, 'searchKey':searchkey};

  }
}