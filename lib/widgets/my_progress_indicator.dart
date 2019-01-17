import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 4,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        )
    );
  }
}