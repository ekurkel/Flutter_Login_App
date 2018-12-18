import 'package:flutter/material.dart';
import 'package:flutter_login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: new AppBar(title: new Text('Login')),
          body: new Center(
              child: new ListView(children: <Widget>[
              new LoginScreen(),
            ])
          )),
    );
  }
}
