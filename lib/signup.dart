import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'api.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupPage(),
    );
  }
}
class SignupPage extends StatefulWidget {
  SignupPage() : super();
  SignupPageState createState() => SignupPageState();
}
class SignupPageState extends State<SignupPage> {

  double screenHeight;
  bool showTextField = false;
  String _email,_password;
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
//  TextEditingController controllerName = TextEditingController();
//  TextEditingController controllerEmail = TextEditingController();
//  TextEditingController controllerPassword = TextEditingController();

  void Signup() async
  {
//    addNewUser(controllerName.text,controllerEmail.text,controllerPassword.text);
//    controllerName.text='';
//    controllerEmail.text='';
//    controllerPassword.text='';
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try
      {
          FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
          user.sendEmailVerification();
          Navigator.of(context).pop();
      }
      catch(e)
    {
      print(e.message);
    }
    }
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
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            lowerSection(context),
            upperSection(context),
            signupSection(context)
          ],
        ),
      ),
    );
  }
  Widget upperSection(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'images/flower1.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
  Widget lowerSection(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 3,
        color: Color(0xFFECF0F3),
      ),
    );
  }
  Widget signupSection(BuildContext context) {
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
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "WELCOME TO OUR LEARN A FLOWER APP",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (input){
                      if(input.isEmpty){
                        'Please enter your email address';
                      }
                    },
                    onSaved: (input) => _email=input,
                   // controller: controllerEmail,
                    decoration: InputDecoration(
                        labelText: "Email", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (input){
                      if(input.length<6){
                        'You need to provide password with atleast 6 charcters';
                      }
                    },
                    onSaved: (input) => _password=input,
                   // controller: controllerEmail,
                    decoration: InputDecoration(
                        labelText: "Password", hasFloatingPlaceholder: true),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        child: Text("SIGN UP"),
                        color: Color(0xFF4B9DFE),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          Signup();
//                        setState(() {
//                          showTextField = false;
//                        });},
                        }
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
}