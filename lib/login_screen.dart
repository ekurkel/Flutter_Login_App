import 'package:flutter/material.dart';
import 'package:flutter_login/list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(30.0),
        child: Center(
            child: ListView(children: <Widget>[
           Form(
              child:  Column(children: <Widget>[
             ImageWidget(),
             TextField(
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
             SizedBox(height: 20.0),
             TextField(
              decoration: InputDecoration(labelText: 'Password'),
            ),
             SizedBox(height: 30.0),
             Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   FlatButton(
                      onPressed: null,
                      child: Text('Forgot password',
                          style: TextStyle(color: Colors.blue))),
                   RaisedButton(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: openNewPage,
                      color: Colors.blue),
                ]),
             SizedBox(height: 50.0),
             Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Text('Still do not have an account '),
                   FlatButton(
                      onPressed: null,
                      child: Text('registration',
                          style: TextStyle(color: Colors.blue)))
                ])
          ]))
        ])));
  }

  void openNewPage() {
    Navigator.of(context)
        .push( MaterialPageRoute<void>(builder: (BuildContext context) {
      return  ListScreen();
    }));
  }
}

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = AssetImage('assets/butterfly.png');
    var image =  Image(image: assetsImage, width: 200.0, height: 200.0);
    return Container(
      child: image,
    );
  }
}
