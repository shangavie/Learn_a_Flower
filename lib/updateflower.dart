import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'flower.dart';
import 'api.dart';

void main() => runApp(App());

class App extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Title',
      home: UpdateFlowerPage(),
    );
  }
}

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
  var uploadedBy;
  checkValidUser(DocumentSnapshot flower,Flower flower1)
  async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = (await _firebaseAuth.currentUser());
    var uploadedBy = flower.data["LoggedUser"];
    var loggedInUser = user.email;
    if (uploadedBy == loggedInUser) {
      setUpdateUI(flower1);
    }
    else {
      print(uploadedBy);
      print(loggedInUser);
      showAlertMessage(context);
    }
  }
  update()  {
    try {
      if (isEditing) {
        updateFlowerDetails(
            updateflower, controllerDescription.text, controllerSunlight.text,
            controllerBlooms.text, controllerSoil.text);
        setState(() {
          isEditing = false;
        });
      }
      controllerFlowerName.text = '';
      controllerDescription.text = '';
      controllerSunlight.text = '';
      controllerBlooms.text = '';
      controllerSoil.text = '';
      showMessage(context);
    }
    catch(e)
    {
      
    }
    }
  showAlertMessage(BuildContext context) {
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
      content: Text("You are not authorized to edit this entry !"),
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
            checkValidUser(data,flower);
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

        elevation: 5.0,
        backgroundColor: Color.fromRGBO(61, 212, 125, 100),

        title: Row(
          children: <Widget>[
            SizedBox(
              width: 15,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 8, 10, 8),
                child: CircleAvatar(
                  backgroundImage: ExactAssetImage('images/logo.png'),
                  radius: 25.0,
                ),
                decoration: new BoxDecoration(
                  border: new Border.all(
                    color: Colors.pink,
                    width: 1.0,
                  ),
                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                )),
            Container(
              //margin: EdgeInsets.fromLTRB(0, 0, 130, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'FlowerSnap',
                        style: TextStyle(fontSize: 25.0, fontFamily: 'Lobster'),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 12.0,
                        ),
                        SizedBox(width: 4.0),
                        Text('Learn Flower Details',
                            style: TextStyle(fontSize: 12.0))
                      ],
                    ),
                  ]),
            )
          ],
        ),

      ),
      body: Form(
        child:Container(
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill the field';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill the field';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill the field';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill the field';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  child: Text("UPDATE"),
                  color: Color.fromRGBO(61, 212, 125, 100),
                  textColor: Colors.white,
                  padding: EdgeInsets.only(
                      left: 38, right: 38, top: 15, bottom: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: (){
                    update();
                    setState(() {
                      showTextField = false;
                    });
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
      ),
    );
  }
}
