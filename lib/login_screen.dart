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
        child: new Form(
            child: new Column(children: <Widget>[
          new ImageWidget(),
          new TextField(
            decoration: InputDecoration(labelText: 'E-mail'),
          ),
          new SizedBox(height: 20.0),
          new TextField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
          new SizedBox(height: 30.0),
          new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new FlatButton(
                    onPressed: null,
                    child: Text('Forgot password',
                        style: TextStyle(color: Colors.blue))),
                new RaisedButton(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: openNewPage,
                    color: Colors.blue),
              ]),
          new SizedBox(height: 50.0),
          new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('Still do not have an account '),
                new FlatButton(
                    onPressed: null,
                    child: Text('registration',
                        style: TextStyle(color: Colors.blue)))
              ])
        ])));
  }

  void openNewPage() {
    Navigator.of(context)
        .push(new MaterialPageRoute<void>(builder: (BuildContext context) {
      return new ListScreen();
    }));
  }
}

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/butterfly.png');
    var image = new Image(image: assetsImage, width: 200.0, height: 200.0);
    return Container(
      child: image,
    );
  }
}
