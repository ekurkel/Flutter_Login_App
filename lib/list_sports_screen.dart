import 'package:flutter/material.dart';
import 'package:flutter_login/widgets/my_progress_indicator.dart';
import 'dart:async';
import 'package:flutter_login/model/sport.dart';
import 'package:flutter_login/sport_info_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListSports extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListSportsState();
}

class ListSportsState extends State<ListSports> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: _getListSports(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return snapshot.data[index];
                      })
                  : MyProgressIndicator();
            }));
  }

  Future<List<ListTile>> _getListSports() async {
    var data = await http
        .get("https://www.thesportsdb.com/api/v1/json/1/all_sports.php");
    var jsonData = json.decode(data.body);

    List<ListTile> listTiles = [];

    for (var d in jsonData["sports"]) {
      Sport sport = Sport(d["strSport"].toString(), Image.network(d["strSportThumb"]),
          d["strSportDescription"]);

      ListTile lt = ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SportInfo(sport)));
        },
        title: Text(sport.sportName),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.blue,
        ),
        leading: Image.network(
          d["strSportThumb"],
          width: 100,
        ),
      );
      listTiles.add(lt);
    }
    return listTiles;
  }
}
