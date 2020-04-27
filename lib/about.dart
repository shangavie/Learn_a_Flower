import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  AboutState createState() {
    return AboutState();
  }
}

class AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("FlowerSnap"),
          elevation: 20.0,
          backgroundColor: Color.fromRGBO(61, 212, 125, 100),
          actionsIconTheme:
          IconThemeData(size: 30.0, color: Colors.white, opacity: 100.0),
        ),
        //body:
    );
  }
}
