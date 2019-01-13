import 'package:flutter/material.dart';
import 'package:flutter_login/my_progress_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_login/image_widget.dart';
import 'dart:async';

class AccoutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountScreenState();
}

class AccountScreenState extends State<AccoutScreen> {
  String selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Account')),
        body: Container(
          child: Center(
              child: ListView(children: <Widget>[
            Column(children: <Widget>[
              SizedBox(height: 20.0),
              ImageWidget(),
              Container(
                padding: const EdgeInsets.only(right: 35.0, left: 35),
                child: Column(children: <Widget>[
                  SizedBox(height: 10.0),
                  TextField(decoration: InputDecoration(labelText: 'E-mail')),
                  SizedBox(height: 10.0),
                  TextField(decoration: InputDecoration(labelText: 'Name')),
                  SizedBox(height: 10.0),
                  FutureBuilder(
                      future: listDrop(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return snapshot.hasData
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: DropdownButton(
                                  value: selected,
                                  hint: Text("Select your country"),
                                  items: snapshot.data,
                                  onChanged: (value) {
                                    selected = value;
                                    setState(() {});
                                  },
                                ))
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: MyProgressIndicator());
                      }),
                  RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ]),
              )
            ])
          ])),
        ));
  }

  Future<List<DropdownMenuItem<String>>> listDrop() async {
    var data = await DefaultAssetBundle.of(context).loadString("assets/countries.json");
    var jsonData = json.decode(data);

    List<DropdownMenuItem<String>> listDrops = [];
    for (var d in jsonData) {
      listDrops.add(DropdownMenuItem(
        child: Text(d["name"].toString()),
        value: d["code"],
      ));
      // print(d["name"]);
    }
    return listDrops;
  }
}

