import 'package:flutter/material.dart';
import 'package:flutter_login/my_progress_indicator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.onSignedOut});
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home'), actions: <Widget>[
          IconButton(
              onPressed: logOut,
              icon: Icon(Icons.exit_to_app, color: Colors.white)),
          IconButton(
              onPressed: share, icon: Icon(Icons.share, color: Colors.white)),
        ]),
        body: Container(
            child: FutureBuilder(
                future: _getListTiles(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data[index];
                          })
                      : MyProgressIndicator();
                })));
  }

  Future<List<ListTile>> _getListTiles() async {
    var data = await http.get("http://api.myjson.com/bins/8jxuc");
    var jsonData = json.decode(data.body);

    List<ListTile> listTiles = [];

    for (var d in jsonData) {
      ListTile lt = ListTile(
        title: Text(d["title"].toString(),),
        subtitle: Text(d["subtitle"].toString(),),
        trailing: const Icon(
          Icons.local_grocery_store,
          color: Colors.blue,
        ),
        leading: const Icon(
          Icons.android,
          color: Colors.green,
        ),
      );
      listTiles.add(lt);
    }

    return listTiles;
  }

  void share() {}

  void logOut() {
    widget.onSignedOut();
  }
}

