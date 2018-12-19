import 'package:flutter/material.dart';
import 'package:flutter_login/login_screen.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:flutter_login/home_screen.dart';

class Screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScreenState();
}

enum AuthorizationStatus {
  notSignedIn,
  signedIn,
  notDetermined
}

class ScreenState extends State<Screen> {
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
        return JumpingDots();
    }
  }
}

class JumpingDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text('Home screen')),
            body: Center(
              child: JumpingDotsProgressIndicator(
                  fontSize: 50.0, color: Colors.blue, milliseconds: 250),
            )));
  }
}
