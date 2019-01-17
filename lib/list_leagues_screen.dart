import 'package:flutter/material.dart';
import 'package:flutter_login/widgets/my_progress_indicator.dart';
import 'package:flutter_login/widgets/countries_drop_down.dart';
import 'dart:async';
import 'package:flutter_login/list_teams_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Leagues extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LeaguesState();
}

class LeaguesState extends State<Leagues> {
  String _country;
  String _sport;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            SizedBox(width: 10),
            FutureBuilder(
                future: CoutriesDropDown.listDrop(context),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? DropdownButton(
                          value: _country,
                          hint: Text("Select country"),
                          items: snapshot.data,
                          onChanged: (value) {
                            _country = value;
                            setState(() {});
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: MyProgressIndicator());
                }),
            SizedBox(width: 10),
            FutureBuilder(
                future: _getListSports(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? DropdownButton(
                          value: _sport,
                          hint: Text("Select sport"),
                          items: snapshot.data,
                          onChanged: (value) {
                            _sport = value;
                            setState(() {});
                          },
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: //MyProgressIndicator());
                  Text(" "));
                }),
          ]),
          Flexible(
              child: FutureBuilder(
                  future: _getListLeagues(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return snapshot.data[index];
                            })
                        : Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: MyProgressIndicator());
                  }))
        ]),
      ),
    );
  }

  Future<List<DropdownMenuItem<String>>> _getListSports() async {
    var data = await http
        .get("https://www.thesportsdb.com/api/v1/json/1/all_sports.php");
    var jsonData = json.decode(data.body);

    List<DropdownMenuItem<String>> listDrops = [];
    listDrops.add(DropdownMenuItem(child: Text("All Sports"), value: null));

    for (var d in jsonData["sports"]) {
      listDrops.add(DropdownMenuItem(
        child: Row(children: <Widget>[
          Image.network(
            d["strSportThumb"],
            width: 70,
          ),
          SizedBox(width: 10),
          Text(d["strSport"].toString()),
        ]),
        value: d["strSport"],
      ));
      // print(d["name"]);
    }
    return listDrops;
  }

  Future<List<ListTile>> _getListLeagues() async {
    http.Response data;
    String _str = "countrys";
    List<ListTile> listTiles = [];

    if (_country != null) {
      if (_sport == null)
        data = await http.get(
            "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=$_country");
      else
        data = await http.get(
            "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=$_country&s=$_sport");
    } else {
      data = await http
          .get("https://www.thesportsdb.com/api/v1/json/1/all_leagues.php");
      _str = "leagues";
    }

    var jsonData = json.decode(data.body);

    for (var d in jsonData[_str]) {
      if (((_sport != null) & (_sport == d["strSport"])) | (_sport == null)) {
        ListTile lt = ListTile(
          onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LeagueInfo(d["idLeague"], d["strLeague"])));},
          title: Text(d["strLeague"]),
          subtitle: Text(d["strSport"]),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
          ),
        );
        listTiles.add(lt);
      }
    }
    return listTiles;
  }
}
