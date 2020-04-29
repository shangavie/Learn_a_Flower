import 'package:flutter/material.dart';
import 'dart:async';
import 'login.dart'; // To load login page

void main() {
  runApp(MaterialApp(
    home: WelcomeScreen(),
  ));
}

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WelcomeScreenState();
  }
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }
  //To display the welcome screen for 8 seconds
  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 8), onDoneLoading);
  }
  //Display login screen after the welcome screen(It will display after 8 seconds)
  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
//Display welcome screen
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/animatedflower.gif'),
            fit: BoxFit.cover
        ) ,
      ),
    );
  }
}
