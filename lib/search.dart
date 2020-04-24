import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnaflower/searchservice.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() {
    return SearchState();
  }
}

class SearchState extends State<Search> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("FlowerSnap"),
          elevation: 20.0,
          backgroundColor: Color.fromRGBO(61, 212, 125, 100),
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
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search by flower name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
          SizedBox(height: 10.0),
          GridView.count(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              crossAxisCount: 1,
              //crossAxisSpacing: 4.0,
              //mainAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              children: tempSearchStore.map((element) {
                return buildResultCard(element);
              }).toList())
        ]));
  }
}

Widget buildResultCard(data) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
          child: Column(
        children: <Widget>[
          Expanded(
            flex: 6, // 60%
            child: Container(
              width: 200.0, //MediaQuery.of(context).size.width,
              height: 200.0,
              child: Image.network(data["image"], fit: BoxFit.fill),
            ),
          ),
          Expanded(
            flex: 2, // 20%
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Text(data["name"],
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold))),
          ),
          Expanded(
            flex: 3, // 30%
            child: Container(
                padding: EdgeInsets.fromLTRB(20, 2, 20, 10),
                child: Text(
                  data["description"],
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                )),
          ),
          Expanded(
            flex: 2, // 20%
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child:
                          Icon(Icons.wb_sunny, color: Colors.white, size: 20.0),
                    ),
                    Text(
                      data["sunlight"],
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                  ]),
            ),
          ),
          Expanded(
            flex: 2, // 20%
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Icon(Icons.filter_hdr,
                          color: Colors.white, size: 20.0),
                    ),
                    Text(
                      data["soil"],
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                  ]),
            ),
          ),
          Expanded(
            flex: 2, // 20%
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Icon(Icons.local_florist,
                          color: Colors.white, size: 20.0),
                    ),
                    Text(
                      data["blooms"],
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                  ]),
            ),
          ),
        ],
      )));

  /*
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
        child: new Column(
          children: <Widget>[
            Container(
              width: 300.0, //MediaQuery.of(context).size.width,
              height: 200.0,
              child: Image.network(data["image"], fit: BoxFit.fill),
            ),
            Center(
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: Text(data["name"],
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)))),
            Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Text(
                  data["description"],
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                )),
          ],
        ),
      )
  );
*/

  /*
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
        child: new Column(
          children: <Widget>[
            Container(
              width: 300.0, //MediaQuery.of(context).size.width,
              height: 200.0,
              child: Image.network(data["image"], fit: BoxFit.fill),
            ),
            Center(
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: Text(data["name"],
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)))),
            Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Text(
                  data["description"],
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                )),
          ],
        ),
      ));

   */
}
