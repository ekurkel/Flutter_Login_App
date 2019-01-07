import 'package:flutter/material.dart';
import 'package:flutter_login/home_screen.dart';
import 'package:flutter_login/my_progress_indicator.dart';
import 'package:flutter_login/login_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthScreenState();
}

enum AuthorizationStatus { NOT_SIGNED_IN, SIGNED_IN, NOT_DETERMINED }

class AuthScreenState extends State<AuthScreen> {
  AuthorizationStatus _authStatus = AuthorizationStatus.NOT_SIGNED_IN;

  void _signedIn() {
    setState(() {
      _authStatus = AuthorizationStatus.SIGNED_IN;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthorizationStatus.NOT_SIGNED_IN;
    });
  }

  void _waiting() {
    setState(() {
      _authStatus = AuthorizationStatus.NOT_DETERMINED;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthorizationStatus.SIGNED_IN:
        return HomeScreen(onSignedOut: _signedOut);
      case AuthorizationStatus.NOT_SIGNED_IN:
        return LoginScreen(onSignedIn: _signedIn, onWaiting: _waiting);
      case AuthorizationStatus.NOT_DETERMINED:
        return Scaffold(
                appBar: AppBar(
                  title: Text('Login'),
                  backgroundColor: Colors.blue,
                ),
                body: MyProgressIndicator());
    }
  }
}
