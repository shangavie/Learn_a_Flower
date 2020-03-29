import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnaflower/search.dart';


class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("FlowerSnap"),
        elevation: 20.0,
        backgroundColor: Color.fromRGBO(61, 212, 125, 100),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        actions: <Widget>[

          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.account_circle,
                size: 26.0,
              ),
            ),
          )
        ],
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
                  image: NetworkImage('https://i.pinimg.com/originals/17/56/20/1756208b78720991768297bf89d27f2b.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Color.fromRGBO(61, 212, 125, 100),
              ),
              title: Text("Home"),
              onTap: () {
                //Navigate to Home
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
                Icons.search,
                color: Color.fromRGBO(61, 212, 125, 100),
              ),
              title: Text("Search Flower Details"),
              onTap: () {
                //Navigate to Search Flower Details
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Search())
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.star,
                color: Color.fromRGBO(61, 212, 125, 100),
              ),
              title: Text("Favourites"),
              onTap: () {
                //Navigate to Favourites
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
                        builder: (context) => View())
                );
                 */
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
    QuerySnapshot qn = await firestore.collection("flower").getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot flower) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
              flower: flower,
            )));
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
            }
            else{
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
                                    snapshot.data[index].data["image"],
                                    fit: BoxFit.fill),
                              ),
                              new ListTile(
                                title: Text(snapshot.data[index].data["name"]),
                                trailing: Icon(
                                  Icons.keyboard_arrow_right,
                                ),
                                onTap: () =>
                                    navigateToDetail(snapshot.data[index]),
                              ),
                              ButtonBar(
                                mainAxisSize: MainAxisSize
                                    .min,
                                children: <Widget>[
                                  new RaisedButton(
                                    child: new Text('Feature'),
                                    onPressed: () {
                                      /*
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => View())
                                              );
                                       */
                                    },
                                    color: Colors.orange,
                                    textColor: Colors.white,
                                  ),
                                  new RaisedButton(
                                    child: new Text('Update'),
                                    onPressed: () => {},
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                  ),
                                  new RaisedButton(
                                    child: new Text('Delete'),
                                    onPressed: () => {},
                                    color: Colors.red,
                                    textColor: Colors.white,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.greenAccent,
                                    child: Icon(Icons.thumb_up,
                                        color: Colors.white, size: 30.0),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.redAccent,
                                    child: Icon(Icons.thumb_down,
                                        color: Colors.white, size: 30.0),
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
        title: Text(widget.flower.data["name"]),
        backgroundColor: Color.fromRGBO(61, 212, 125, 100),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[],
        actionsIconTheme:
        IconThemeData(size: 30.0, color: Colors.white, opacity: 100.0),
      ),

      body: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Card(
          child: new Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                child: Image.network(widget.flower.data["image"],
                    fit: BoxFit.fill),
              ),
              SizedBox(height: 18.0),
              Text(
                widget.flower.data["name"],
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 18.0),
              Text(
                widget.flower.data["description"],
                style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
              SizedBox(height: 20.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child:
                      Icon(Icons.wb_sunny, color: Colors.white, size: 30.0),
                    ),
                    Text(
                      widget.flower.data["sunlight"],
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                  ]),
              SizedBox(height: 20.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Icon(Icons.filter_hdr,
                          color: Colors.white, size: 30.0),
                    ),
                    Text(
                      widget.flower.data["soil"],
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                  ]),
              SizedBox(height: 20.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Icon(Icons.local_florist,
                          color: Colors.white, size: 30.0),
                    ),
                    Text(
                      widget.flower.data["blooms"],
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}