import 'package:flutter/material.dart';
import 'package:flutter_login/my_progress_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class AccoutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountScreenState();
}

var picture = Image(
    image: AssetImage("assets/male-avatar.jpg"), width: 200.0, height: 200.0);

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
    var data = await http.get("https://api.myjson.com/bins/fa520");
    var jsonData = json.decode(data.body);

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

class ImageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImageWidgetState();
}

class ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
            icon: picture,
            iconSize: 200,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // return object of type Dialog
                  return AlertDialog(
                    title: new Text("Image source"),
                    content: new Text("Select an image source"),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      new FlatButton(
                        child: new Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      new FlatButton(
                          child: new Text("Camera"),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            var img = Image.file(await ImagePicker.pickImage(
                                source: ImageSource.camera));
                            setState(() {
                              if (img != null) picture = img;
                            });
                          }),
                      new FlatButton(
                        child: new Text("Gallery"),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          var img = Image.file(await ImagePicker.pickImage(
                              source: ImageSource.gallery));
                          setState(() {
                            if (img != null) picture = img;
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            }));
  }
}
