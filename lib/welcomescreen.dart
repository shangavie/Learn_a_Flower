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
/*Title:Create splash screen in Flutter
 * Date:2019
 * Availability:https://fluttermaster.com/create-splash-screen-in-flutter/
 */
class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    loadingProcess();
  }
  //To display the welcome screen for 8 seconds
  Future<Timer> loadingProcess() async {
    return new Timer(Duration(seconds: 8), loadingNextScreen);
  }
  //Display login screen after the welcome screen(It will display after 8 seconds)
  loadingNextScreen() async {
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
