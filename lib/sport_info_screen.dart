import 'package:flutter/material.dart';
import 'package:flutter_login/model/sport.dart';

class SportInfo extends StatelessWidget {
  final Sport _sport;
  SportInfo(this._sport);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_sport.sportName),
        ),
        body: Container(
          child: Center(
            child: ListView(children: <Widget>[
              Column(children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                _sport.picture,
                SizedBox(
                  height: 20,
                ),
                Text(
                  _sport.sportName,
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(_sport.sportDescription,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify))
              ]),
            ]),
          ),
        ));
  }
}
