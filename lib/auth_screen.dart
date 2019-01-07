import 'package:flutter/material.dart';
import 'package:flutter_login/home_screen.dart';
import 'package:flutter_login/login_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthScreenState();
}

enum AuthorizationStatus {
  notSignedIn,
  signedIn,
  notDetermined
}

class AuthScreenState extends State<AuthScreen> {
  AuthorizationStatus _authStatus = AuthorizationStatus.notSignedIn;

  void _signedIn() {
    setState(() {
      _authStatus = AuthorizationStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthorizationStatus.notSignedIn;
    });
  }

  void _waiting() {
    setState(() {
      _authStatus = AuthorizationStatus.notDetermined;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthorizationStatus.signedIn:
        return HomeScreen(onSignedOut: _signedOut);
      case AuthorizationStatus.notSignedIn:
        return LoginScreen(onSignedIn: _signedIn, onWaiting: _waiting);
      case AuthorizationStatus.notDetermined:
        return ProgressIndicator();
    }
  }
}

class ProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text('Home'), backgroundColor: Colors.blue,),
            body: Center(
                child: CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 4, valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),)
            )
        )
    );
  }
}