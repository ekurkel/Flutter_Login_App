import 'package:flutter/material.dart';
import 'package:flutter_login/widgets/avatar_image_widget.dart';
import 'package:flutter_login/widgets/countries_drop_down.dart';
import 'package:flutter_login/widgets/my_progress_indicator.dart';

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
                  child: Form(
                    child: Column(children: <Widget>[
                      SizedBox(height: 10.0),
                      TextField(
                          decoration: InputDecoration(labelText: 'E-mail')),
                      SizedBox(height: 10.0),
                      TextField(decoration: InputDecoration(labelText: 'Name')),
                      SizedBox(height: 10.0),
                      FutureBuilder(
                          future: CoutriesDropDown.listDrop(context),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return snapshot.hasData
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
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
                  ))
            ])
          ])),
        ));
  }
}
