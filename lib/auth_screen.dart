import 'package:flutter/material.dart';
import 'package:flutter_login/home_screen.dart';
import 'package:flutter_login/widgets/my_progress_indicator.dart';
import 'package:flutter_login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthScreenState();
}

enum AuthorizationStatus { NOT_SIGNED_IN, SIGNED_IN, WAITING }

class AuthScreenState extends State<AuthScreen> {
  FirebaseUser _user;
  AuthorizationStatus _authStatus = AuthorizationStatus.WAITING;

  AuthScreenState() {
    _signedIn();
  }

  void _signedIn() async {
    SharedPreferences sPref = await SharedPreferences.getInstance();
    String login = sPref.getString("Login") ?? null;
    String password = sPref.getString("Password") ?? null;
    if (login != null && password != null) {
      _user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: login, password: password);
      setState(() {
        _authStatus = AuthorizationStatus.SIGNED_IN;
      });
    }
  }

  void _onGoogleSignedIn(FirebaseUser user) {
    _user = user;
    setState(() {
      _authStatus = AuthorizationStatus.SIGNED_IN;
    });
  }

  void _signedOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("Login");
    pref.remove("Password");
    setState(() {
      _authStatus = AuthorizationStatus.NOT_SIGNED_IN;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (_authStatus == AuthorizationStatus.WAITING)
      _authStatus = AuthorizationStatus.NOT_SIGNED_IN;

    switch (_authStatus) {
      case AuthorizationStatus.SIGNED_IN:
        return HomeScreen(
          onSignedOut: _signedOut,
          user: _user,
        );
      case AuthorizationStatus.NOT_SIGNED_IN:
        return LoginScreen(
          onSignedIn: _signedIn,
          onGoogleSignedIn: _onGoogleSignedIn,
          signOut: _signedOut,
        );
      case AuthorizationStatus.WAITING:
        return Scaffold(
          appBar: AppBar(title: Text("Login")),
          body: Center(child: MyProgressIndicator()),
        );
    }
  }
}
