import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnaflower/home.dart';
import 'flower.dart';
import 'api.dart';

/*
void main() => runApp(App());

class App extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Title',
      home: UpdateFlowerPage(),
    );
  }
}

 */


class UpdateFlowerPage extends StatefulWidget{
  UpdateFlowerPage() : super();
  UpdateFlowerPageState createState() => UpdateFlowerPageState();
}

class UpdateFlowerPageState extends State<UpdateFlowerPage>{
  bool showTextField = false;
  TextEditingController controllerFlowerName = TextEditingController();
  TextEditingController controllerDescription= new TextEditingController();
  TextEditingController controllerSunlight= new TextEditingController();
  TextEditingController controllerBlooms= new TextEditingController();
  TextEditingController controllerSoil= new TextEditingController();
  bool isEditing = false;
  //String url;
  Flower updateflower;
  Future<File> imageFile;

  update(){
    if(isEditing){
      updateFlowerDetails(updateflower, controllerDescription.text,controllerSunlight.text,controllerBlooms.text,controllerSoil.text);
      setState(() {
        isEditing=false;
      });
    }
    controllerFlowerName.text = '';
    controllerDescription.text = '';
    controllerSunlight.text='';
    controllerBlooms.text='';
    controllerSoil.text='';
  }
//  File sampleImage;
//
//  Future getImage() async {
//    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//    setState(() {
//      sampleImage = tempImage;
//    });
//  }

  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getFlowerDetail(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if(snapshot.hasData){
          print("Documents ${snapshot.data.documents.length}");
          return buildList(context, snapshot.data.documents);
        }
        return CircularProgressIndicator();
      },
    );
  }
  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => buildListItem(context, data)).toList(),
    );
  }
  Widget buildListItem(BuildContext context, DocumentSnapshot data){
    final flower=Flower.fromSnapshot(data);
    return Padding(
      key:ValueKey(flower.fname),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(flower.fname),
          trailing: Container(
            width: 50.0,
            height: 50.0,
            child: Image.network(
               flower.furl,
                fit: BoxFit.contain),
          ),
          onTap: (){
            //update
            setUpdateUI(flower);
          },
        ),
      ),
    );
  }
  setUpdateUI(Flower flower){
    controllerFlowerName.text = flower.fname;
    controllerDescription.text = flower.description;
    controllerSunlight.text = flower.sunlight;
    controllerBlooms.text = flower.blooms;
    controllerSoil.text = flower.soil;
//    Container(
//      width: 50.0,
//      height: 50.0,
//      child: Image.network(
//          flower.furl.toString(),
//          fit: BoxFit.contain),
//    );
    setState(() {
      showTextField = true;
      isEditing = true;
      updateflower = flower;
    });
  }
  showMessage(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("FlowerSnap"),
      content: Text("Flower details are updated successfully!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("FlowerSnap"),
        elevation: 5.0,
        backgroundColor: Color.fromRGBO(61, 212, 125, 100),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://lh3.googleusercontent.com/proxy/xc5VEvWkaw97-1-krACJOc4yrmifxhw_Pr4Y0Wg0BQ_S8JVPj5bDLcf5GDSBL6ruZunRf4kms57Ek5K0_KTV9c7HMb0GuaEqkvCTsuw73EChM24e87sbI6O7oPkE3syYyjH47rm5qUzi406k2yAP'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
        showTextField
             ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
               TextFormField(
                 enabled: false,
                  controller: controllerFlowerName,
                    decoration: InputDecoration(
                      labelText: "Flower Name", hasFloatingPlaceholder: false,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                ),
                SizedBox(
                  height: 10,
                ),

                TextFormField(
                  controller: controllerDescription,
                  decoration: InputDecoration(
                    labelText: "Description", hasFloatingPlaceholder: false,
                    hintText: "Description",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: controllerSunlight,
                  decoration: InputDecoration(
                    labelText: "Sunlight", hasFloatingPlaceholder: false,
                    hintText: "Sunlight",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: controllerBlooms,
                  decoration: InputDecoration(
                    labelText: "Blooms", hasFloatingPlaceholder: false,
                    hintText: "Blooms",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: controllerSoil,
                  decoration: InputDecoration(
                    labelText: "Soil", hasFloatingPlaceholder: false,
                    hintText: "Soil",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  child: Text("UPDATE"),
                  color: Color.fromRGBO(61, 212, 125, 100),
                  textColor: Colors.white,
                  padding: EdgeInsets.only(
                      left: 38, right: 38, top: 15, bottom: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: (){
                    update();
                    setState(() {
                      showTextField = false;
                    });
                    showMessage(context);
                      //Navigator.of(context).pop();
                  },
                ),
              ],
            )
            :Container(),
            Flexible(
              child: buildBody(context),
            ),
          ],
        ),
      ),
    );
  }
}
