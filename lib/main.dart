import 'package:learnaflower/home.dart';
import 'package:flutter/material.dart';
import 'package:learnaflower/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlowerSnap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
//import 'package:flutter/material.dart';
//
//void main() => runApp(MyApp());
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: LoginPage(),
//    );
//  }
//}
//class LoginPage extends StatefulWidget {
//  @override
//  _LoginPageState createState() => _LoginPageState();
//}
//class _LoginPageState extends State<LoginPage> {
//
//  // To adjust the layout according to the screen size
//  // so that our layout remains responsive ,we need to
//  // calculate the screen height
//  double screenHeight;
//  @override
//  Widget build(BuildContext context) {
//
//    screenHeight = MediaQuery.of(context).size.height;
//    return Scaffold(
//      body: SingleChildScrollView(
//        child: Stack(
//          children: <Widget>[
//            lowerHalf(context),
//            upperHalf(context),
//            loginCard(context)
//          ],
//        ),
//      ),
//    );
//  }
//  Widget upperHalf(BuildContext context) {
//    return Container(
//      height: screenHeight / 2,
//      child: Image.asset(
//        'images/flower1.jpg',
//        fit: BoxFit.cover,
//      ),
//    );
//  }
//  Widget lowerHalf(BuildContext context) {
//    return Align(
//      alignment: Alignment.bottomCenter,
//      child: Container(
//        height: screenHeight / 2,
//        color: Color(0xFFECF0F3),
//      ),
//    );
//  }
//  Widget loginCard(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Container(
//          margin: EdgeInsets.only(top: screenHeight / 4),
//          padding: EdgeInsets.only(left: 10, right: 10),
//          child: Card(
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(10),
//            ),
//            elevation: 8,
//            child: Padding(
//              padding: const EdgeInsets.all(30.0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Align(
//                    alignment: Alignment.topCenter,
//                    child: Text(
//                      "WELCOME TO OUR FIND FLOWER APP",
//                      style: TextStyle(
//                        color: Colors.purpleAccent,
//                        fontSize: 14,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 15,
//                  ),
//                  TextFormField(
//                    decoration: InputDecoration(
//                        labelText: "Name", hasFloatingPlaceholder: true),
//                  ),
//                  SizedBox(
//                    height: 20,
//                  ),
//                  TextFormField(
//                    decoration: InputDecoration(
//                        labelText: "Email", hasFloatingPlaceholder: true),
//                  ),
//                  SizedBox(
//                    height: 20,
//                  ),
//                  TextFormField(
//                    decoration: InputDecoration(
//                        labelText: "Password", hasFloatingPlaceholder: true),
//                  ),
//                  SizedBox(
//                    height: 20,
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      FlatButton(
//                        child: Text("SIGN UP"),
//                        color: Color(0xFF4B9DFE),
//                        textColor: Colors.white,
//                        padding: EdgeInsets.only(
//                            left: 38, right: 38, top: 15, bottom: 15),
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(5)),
//                        onPressed: () {},
//                      )
//                    ],
//                  )
//                ],
//              ),
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//}