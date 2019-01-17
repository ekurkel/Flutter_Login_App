import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

class CoutriesDropDown {

 static Future<List<DropdownMenuItem<String>>> listDrop(BuildContext context) async {
    var data = await DefaultAssetBundle.of(context).loadString("assets/countries.json");
    var jsonData = json.decode(data);

    List<DropdownMenuItem<String>> listDrops = [];
    listDrops.add(DropdownMenuItem(
        child: Text("All countries"),
        value: null ));

    for (var d in jsonData) {
      listDrops.add(DropdownMenuItem(
        child: Row(children: <Widget>[
          Image.network(d["picture"], width: 50,),
          SizedBox(width: 10,),
          Text(d["name"].toString()),
        ]),
        value: d["code"],
      ));
      // print(d["name"]);
    }
    return listDrops;
  }
}