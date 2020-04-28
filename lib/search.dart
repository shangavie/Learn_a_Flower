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
  var tempFlowerSearchStore = [];

  initiateFlowerSearch(keyword) {
    if (keyword.length == 0) {
      setState(() {
        queryResultSet = [];
        tempFlowerSearchStore = [];
      });
    }

    var capitalizedString =
        keyword.substring(0, 1).toUpperCase() + keyword.substring(1);

    if (queryResultSet.length == 0 && keyword.length == 1) {
      SearchService().searchFlowerByName(keyword).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempFlowerSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Name'].startsWith(capitalizedString)) {
          setState(() {
            tempFlowerSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          elevation: 20.0,
          backgroundColor: Color.fromRGBO(61, 212, 125, 100),
          title: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 8, 10, 8),
                  child: CircleAvatar(
                    backgroundImage: ExactAssetImage('images/logo.png'),
                    radius: 25.0,
                  ),
                  decoration: new BoxDecoration(
                    border: new Border.all(
                      color: Colors.pink,
                      width: 1.0,
                    ),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                  )),
              Container(
                //margin: EdgeInsets.fromLTRB(0, 0, 130, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'FlowerSnap',
                          style:
                              TextStyle(fontSize: 25.0, fontFamily: 'Lobster'),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 12.0,
                          ),
                          SizedBox(width: 4.0),
                          Text('Learn Flower Details',
                              style: TextStyle(fontSize: 12.0))
                        ],
                      ),
                    ]),
              )
            ],
          ),
          actionsIconTheme:
              IconThemeData(size: 30.0, color: Colors.white, opacity: 100.0),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) {
                initiateFlowerSearch(val);
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
              primary: false,
              shrinkWrap: true,
              children: tempFlowerSearchStore.map((element) {
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
              child: Image.network(data["Url"], fit: BoxFit.fill),
            ),
          ),
          Expanded(
            flex: 2, // 20%
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Text(data["Name"],
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold))),
          ),
          Expanded(
            flex: 3, // 30%
            child: Container(
                padding: EdgeInsets.fromLTRB(20, 2, 20, 10),
                child: Text(
                  data["Description"],
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
                    Flexible(
                      child: Text(data["Sunlight"],
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                          overflow: TextOverflow.ellipsis),
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
                    Flexible(
                      child: Text(data["Soil"],
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                          overflow: TextOverflow.ellipsis),
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
                    Flexible(
                      child: Text(data["Blooms"],
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ]),
            ),
          ),
        ],
      )));
}
