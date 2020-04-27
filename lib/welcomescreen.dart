import 'package:flutter/material.dart';
import 'dart:async';

import 'login.dart';

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

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 8), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/animatedflower.gif'),
            fit: BoxFit.cover
        ) ,
      ),
//      child: Center(
//        child: CircularProgressIndicator(
//          valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
//        ),
//      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome to Homescreen', style: TextStyle(fontSize: 24.0),),
      ),
    );
  }
}