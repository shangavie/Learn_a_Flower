import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  AboutState createState() {
    return AboutState();
  }
}

class AboutState extends State<About> {
  double screenHeight;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: AppBar(
        title: Text("FlowerSnap"),
        elevation: 20.0,
        backgroundColor: Color.fromRGBO(61, 212, 125, 100),
        actionsIconTheme:
            IconThemeData(size: 30.0, color: Colors.white, opacity: 100.0),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 8.0),
          ListTile(
            title: Text('FlowerSnap consolidates a list of flowers along with flower names, a brief description, a photo, and some guidance for those of you who are interested in gardening.'),
          ),
          ListTile(
            title: Text('Logged-in users can:'),
          ),
          ListTile(
            leading: Icon(Icons.local_florist,color: Color.fromRGBO(61, 212, 125, 100),),
            title: Text('View a list of available flower details'),
          ),
          ListTile(
            leading: Icon(Icons.share,color: Color.fromRGBO(61, 212, 125, 100),),
            title: Text('Share flower details'),
          ),
          ListTile(
            leading: Icon(Icons.language,color: Color.fromRGBO(61, 212, 125, 100),),
            title: Text('Browse for further details using suggested references'),
          ),
          ListTile(
            leading: Icon(Icons.add,color: Color.fromRGBO(61, 212, 125, 100),),
            title: Text('Add an entry to the application'),
          ),
          ListTile(
            leading: Icon(Icons.update,color: Color.fromRGBO(61, 212, 125, 100),),
            title: Text('Update an entry uploaded by them'),
          ),
          ListTile(
            leading: Icon(Icons.delete,color: Color.fromRGBO(61, 212, 125, 100),),
            title: Text('Remove an entry uploaded by them'),
          ),
          ListTile(
            leading: Icon(Icons.search,color: Color.fromRGBO(61, 212, 125, 100),),
            title: Text('Search for flower details'),
          ),
        ],
      ),
    );
  }
}
