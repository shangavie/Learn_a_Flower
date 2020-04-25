import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnaflower/flower.dart';
import 'user.dart';


String collectionName1 = "UserManagement";
String collectionName2 = "FlowerDetail";

addNewUser(String Name , String Email , String Password){
  User user = User(name: Name, email: Email, password: Password);
  try{
    Firestore.instance.runTransaction(
          (Transaction transaction) async{
        await Firestore.instance
            .collection(collectionName1)
            .document()
            .setData(user.toJson());
      },
    );
  } catch(e){
    print(e.toString());
  }
}

addNewFlower(String Name , String Description , String Url , String Sunlight , String Blooms , String Soil){
  Flower flower = Flower(fname: Name, description: Description, furl: Url, sunlight: Sunlight, blooms: Blooms, soil: Soil);
  try{
    Firestore.instance.runTransaction(
          (Transaction transaction) async{
        await Firestore.instance
            .collection(collectionName2)
            .document()
            .setData(flower.toJson());
      },
    );
  } catch(e){
    print(e.toString());
  }
}

updateFlowerDetails(Flower flower, String newDescription,String newSunlight, String newBlooms, String newSoil){
  try {
    Firestore.instance.runTransaction((transaction) async {
      await transaction.update(flower.reference, {'Description': newDescription,'Sunlight':newSunlight, 'Blooms':newBlooms, 'Soil':newSoil});
    });
  } catch(e) {
    print(e.toString());
  }
}

getFlowerDetail() {
  return Firestore.instance.collection(collectionName2).snapshots();
}
