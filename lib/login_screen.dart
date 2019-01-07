import 'dart:async';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.onSignedIn, this.onWaiting});
  final VoidCallback onWaiting;
  final VoidCallback onSignedIn;
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login'), backgroundColor: Colors.blue,),
        body: Center(
            child: ListView(children: <Widget>[
              Form(
                  child: Column(children: <Widget>[
                    SizedBox(height: 20.0),
                    ImageWidget(),
                    Container(
                        padding: const EdgeInsets.only(right: 35.0, left: 35),
                        child: Column(children: <Widget>[
                          TextField(
                            decoration: InputDecoration(labelText: 'E-mail'),
                          ),
                          SizedBox(height: 20.0),
                          PasswordField(),
                          SizedBox(height: 30.0),
                        ])),
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
                              onPressed: () async {
                                widget.onWaiting();
                                await new Future.delayed(const Duration(seconds: 3));
                                widget.onSignedIn();
                                //_openNewPage();
                              },
                              color: Colors.blue),
                        ]),
                    SizedBox(height: 60.0),
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
}

class PasswordField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PasswordFieldState();
}

class PasswordFieldState extends State {
  bool _obscurePassword = true; // Initially password is obscure

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon: IconButton(
            onPressed: _toggle,
            icon: Icon(Icons.remove_red_eye),
            color: _obscurePassword ? Colors.grey : Colors.blue,
          )),
      obscureText: _obscurePassword,
    );
  }

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }
}

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = AssetImage('assets/butterfly.png');
    var image = Image(image: assetsImage, width: 200.0, height: 200.0);
    return Container(
      child: image,
    );
  }
}
