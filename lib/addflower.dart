import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddFlowerPage(),
    );
  }
}
class AddFlowerPage extends StatefulWidget {
  @override
  AddFlowerPage() : super();
  AddFlowerPageState createState() => AddFlowerPageState();
}
class AddFlowerPageState extends State<AddFlowerPage> {

  double screenHeight;
  bool showTextField = false;
  TextEditingController controllerFlowerName = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerSunlight = TextEditingController();
  TextEditingController controllerBlooms = TextEditingController();
  TextEditingController controllerSoil = TextEditingController();
  TextEditingController controllerMoreDetail = TextEditingController();
  Future<File> imageFile;
  String url;
  addFlower()
  {
    addNewFlower(controllerFlowerName.text,controllerDescription.text,url,controllerSunlight.text,controllerBlooms.text,controllerSoil.text,controllerMoreDetail.text);
    controllerFlowerName.text='';
    controllerDescription.text='';
    controllerSunlight.text='';
    controllerBlooms.text='';
    controllerSoil.text='';
    controllerMoreDetail.text='';
  }

  File sampleImage;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }
  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            lowerSection(context),
            upperSection(context),
            pageTitle(),
            addFlowerSection(context)
          ],
        ),
      ),
    );
  }
  Widget upperSection(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'images/flower2.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
  Widget lowerSection(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        color: Color(0xFFECF0F3),
      ),
    );
  }
  Widget addFlowerSection(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  showImage(),
                  Align(
                    child: ListTile(
                      title: IconButton(
                        icon: Icon(Icons.camera_alt),
                        iconSize: 40,
                        onPressed: () {
                          pickImageFromGallery(ImageSource.gallery);
                        },
                      ),
                    ),
                  ),

                  TextField(
                    controller: controllerFlowerName,
                    decoration: InputDecoration(
                        labelText: "Flower Name", hasFloatingPlaceholder: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerDescription,
                    decoration: InputDecoration(
                        labelText: "Description", hasFloatingPlaceholder: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerSunlight,
                    decoration: InputDecoration(
                      labelText: "Sunlight", hasFloatingPlaceholder: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerBlooms,
                    decoration: InputDecoration(
                      labelText: "Blooms", hasFloatingPlaceholder: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerSoil,
                    decoration: InputDecoration(
                      labelText: "Soil", hasFloatingPlaceholder: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerMoreDetail,
                    decoration: InputDecoration(
                      labelText: "Url", hasFloatingPlaceholder: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        child: Text("UPLOAD"),
                        color: Color.fromRGBO(61, 212, 125, 100),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () async{
                          //final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('myimage.jpg');
                          final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://lab4-db.appspot.com');
                          //final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);
                          String filePath = 'images/${DateTime.now()}.png';
                          StorageUploadTask _uploadTask= _storage.ref().child(filePath).putFile(sampleImage);
                          var dowurl = await (await _uploadTask.onComplete).ref.getDownloadURL();
                          url = dowurl.toString();
                          addFlower();
                          print(url);
                        setState(() {
                          showTextField = false;
                        });
                          showMessage(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
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
      content: Text("Flower detail is uploaded successfully!"),
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
  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Text(
            "FlowerSnap",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }
  pickImageFromGallery(ImageSource source) async{
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }
  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        sampleImage = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 200,
            height: 200,
          );
        }
        else {
          sampleImage = snapshot.data;
          return const Text(
            'Upload your flower image here',
            textAlign: TextAlign.center,
          );
        }

      },
    );
  }
}