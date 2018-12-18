import 'package:flutter/material.dart';
import 'package:flutter_login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text('Login')),
          body: LoginScreen(),
        )
    );
  }
}
