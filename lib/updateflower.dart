import 'package:flutter/material.dart';

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
  _AddFlowerPageState createState() => _AddFlowerPageState();
}
class _AddFlowerPageState extends State<AddFlowerPage> {

  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  double screenHeight;
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
                  Align(
                    child: ListTile(
//                      title: Text(user.name),
                      title: Image.asset('images/flower3.jpg'),
                     trailing: IconButton(icon: Icon(Icons.camera_alt),padding: const EdgeInsets.fromLTRB(10, 90, 10, 0),iconSize: 30,
                       onPressed: (){
                         List<File> files = await FilePicker.getMultiFile();
                       },),
//                    onTap: (){
//                        //update
//                        setUpdateUI(user);
//                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
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
                    decoration: InputDecoration(
                      labelText: "Description", hasFloatingPlaceholder: true,
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
                        child: Text("UPDATE"),
                        color: Color(0xFF4B9DFE),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {},
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
  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "LEARN A FLOWER",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }
}