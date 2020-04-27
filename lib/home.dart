import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnaflower/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share/share.dart';
import 'package:learnaflower/login.dart';
import 'package:learnaflower/addflower.dart';
import 'package:learnaflower/updateflower.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  HomeState createState() {
    return HomeState();
  }
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
_signOut(BuildContext context) async {
  await _firebaseAuth.signOut();
  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
}

class HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('FlowerSnap'),
        elevation: 20.0,
        backgroundColor: Color.fromRGBO(61, 212, 125, 100),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        actionsIconTheme:
            IconThemeData(size: 30.0, color: Colors.white, opacity: 100.0),
      ),
      body: ListPage(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(61, 212, 125, 100),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/17/56/20/1756208b78720991768297bf89d27f2b.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            /*

            ListTile(

              title: Text(
               'Welcome ${widget.user.email.split('@').removeAt(0).toUpperCase()}',
                style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(61, 212, 125, 100),
                ),
              ),
            ),

             */
            ListTile(
              leading: Icon(
                Icons.home,
                color: Color.fromRGBO(61, 212, 125, 100),
              ),
              title: Text("Home"),
              onTap: () {
                //Navigate to Home

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Color.fromRGBO(61, 212, 125, 100),
              ),
              title: Text("My Profile"),
              onTap: () {
                //Navigate to My Profile
                /*
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => View())
                );
                 */
              },
            ),
            ListTile(
              leading: Icon(
                Icons.local_florist,
                color: Color.fromRGBO(61, 212, 125, 100),
              ),
              title: Text("Add Flower Details"),
              onTap: () {
                //Navigate to Add Flower Details

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddFlowerPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.search,
                color: Color.fromRGBO(61, 212, 125, 100),
              ),
              title: Text("Search Flower Details"),
              onTap: () {
                //Navigate to Search Flower Details
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Search()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.update,
                color: Color.fromRGBO(61, 212, 125, 100),
              ),
              title: Text("Update Flower Details"),
              onTap: () {
                //Navigate to Update Flower Details

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateFlowerPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Color.fromRGBO(61, 212, 125, 100),
              ),
              title: Text("About"),
              onTap: () {
                //Navigate to About
                /*
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => About())
                );
                 */
              },
            ),
            ListTile(
              leading: Icon(
                Icons.power_settings_new,
                color: Color.fromRGBO(61, 212, 125, 100),
              ),
              title: Text("Logout"),
              onTap: () {
                _signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future _data;

  Future getData() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn =
        await firestore.collection("FlowerDetail").getDocuments();
    return qn.documents;
    //return await firestore.collection("flower").snapshots();
  }

  navigateToDetail(DocumentSnapshot flower) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  flower: flower,
                )));
  }
/*
  deleteData(DocumentSnapshot flower) async {
    var firestore = Firestore.instance;
    await firestore.collection("FlowerDetail").document(flower.documentID).delete();
    setState(() {});
  }

 */

  deleteData(DocumentSnapshot flower) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = (await _firebaseAuth.currentUser());

    var uploadedBy = flower.data["LoggedUser"];
    var loggedInUser = user.email;

    if (uploadedBy == loggedInUser) {
      var firestore = Firestore.instance;
      await firestore
          .collection("FlowerDetail")
          .document(flower.documentID)
          .delete();
      setState(() {});
    } else {
      print(uploadedBy);
      print(loggedInUser);
      showMessage(context);
    }
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
      content: Text("You are not authorized to remove this entry !"),
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

  share(BuildContext context, DocumentSnapshot flower) {
    final RenderBox box = context.findRenderObject();
    Share.share(
        "Name: ${flower.data["Name"]} \n Description: ${flower.data["Description"]} \n \n ${flower.data["Url"]}",
        subject: "Flower Details | ${flower.data["Name"]}",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void initState() {
    super.initState();
    _data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getData(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading..."),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Card(
                          child: new Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200.0,
                                child: Image.network(
                                    snapshot.data[index].data["Url"],
                                    fit: BoxFit.fill),
                              ),
                              new ListTile(
                                title: Text(snapshot.data[index].data["Name"]),
                                trailing: Icon(
                                  Icons.keyboard_arrow_right,
                                ),
                                onTap: () =>
                                    navigateToDetail(snapshot.data[index]),
                              ),
                              ButtonBar(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  FlatButton.icon(
                                    color: Colors.blue,
                                    icon: Icon(Icons.share),
                                    label: Text('Share Entry'),
                                    onPressed: () {
                                      share(context, snapshot.data[index]);
                                    },
                                  ),
                                  FlatButton.icon(
                                    color: Colors.red,
                                    icon: Icon(Icons.delete),
                                    label: Text('Remove Entry'),
                                    onPressed: () {
                                      deleteData(snapshot.data[index]);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  });
            }
          }),
    );
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot flower;
  DetailPage({this.flower});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.flower.data["Name"]),
        backgroundColor: Color.fromRGBO(61, 212, 125, 100),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[],
        actionsIconTheme:
            IconThemeData(size: 30.0, color: Colors.white, opacity: 100.0),
      ),
      body: Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Card(
          child: new Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                child:
                    Image.network(widget.flower.data["Url"], fit: BoxFit.fill),
              ),
              Text(
                widget.flower.data["Name"],
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 18.0),
              Container(
                padding: EdgeInsets.fromLTRB(20, 2, 20, 10),
                child: Text(
                  widget.flower.data["Description"],
                  style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 2, 20, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          child: Icon(Icons.wb_sunny,
                              color: Colors.white, size: 30.0),
                        ),
                        Flexible(
                          child: Text(widget.flower.data["Sunlight"],
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ])),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 2, 20, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          child: Icon(Icons.filter_hdr,
                              color: Colors.white, size: 30.0),
                        ),
                        Flexible(
                          child: Text(widget.flower.data["Soil"],
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ])),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 2, 20, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          child: Icon(Icons.local_florist,
                              color: Colors.white, size: 30.0),
                        ),
                        Flexible(
                          child: Text(widget.flower.data["Blooms"],
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ])),
              RaisedButton(
                color: Colors.amber,
                onPressed: () async {
                  if (await canLaunch(widget.flower.data["DetailedUrl"])) {
                    await launch(widget.flower.data["DetailedUrl"]);
                  } else {
                    throw 'Could not launch $widget.flower.data["DetailedUrl"]';
                  }
                },
                child: Text(
                  'View Further Details',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
