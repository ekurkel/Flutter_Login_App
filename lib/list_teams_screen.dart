import 'package:flutter/material.dart';
import 'package:flutter_login/widgets/my_progress_indicator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_login/model/team.dart';
import 'package:flutter_login/team_info_screen.dart';
import 'dart:convert';

class LeagueInfo extends StatefulWidget {
  final String _idLeague;
  final String _leagueName;
  LeagueInfo(this._idLeague, this._leagueName);

  @override
  State<StatefulWidget> createState() =>
      LeagueInfoState(_idLeague, _leagueName);
}

class LeagueInfoState extends State<LeagueInfo> {
  final String _idLeague;
  final String _leagueName;
  LeagueInfoState(this._idLeague, this._leagueName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_leagueName)),
        body: Container(
            color: Colors.white,
            child: FutureBuilder(
                future: _getTeamPages(_idLeague),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? PageView.builder(
                          scrollDirection: Axis.horizontal,
                          // store this controller in a State to save the carousel scroll position
                          controller: PageController(viewportFraction: 0.8),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int itemIndex) {
                            return snapshot.data[itemIndex];
                          })
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: MyProgressIndicator());
                })));
  }

  Future<List<Widget>> _getTeamPages(String _idLeague) async {
    var data = await http.get(
        "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=$_idLeague");
    List<Widget> listTeamPages = [];
    var jsonData = json.decode(data.body);
    for (var d in jsonData["teams"])
      listTeamPages.add(Padding(
          padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          child: GestureDetector(
              onTap: () {
                Team team = Team(
                    d["strTeam"],
                    d["strTeamBadge"],
                    d["strDescriptionEN"],
                    d["strYoutube"],
                    d["strInstagram"],
                    d["strFacebook"],
                    d["strWebsite"]);
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return TeamInfo(team);
                }));
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                        right:
                            BorderSide(color: Colors.lightBlueAccent, width: 5),
                        top:
                            BorderSide(color: Colors.lightBlueAccent, width: 5),
                        left: BorderSide(color: Colors.indigoAccent, width: 5),
                        bottom:
                            BorderSide(color: Colors.indigoAccent, width: 5),
                      ),
                      color: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(d["strTeam"].toString(),
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center),
                      SizedBox(height: 50),
                      Hero(
                        tag: 'imageTeamHero${d["strTeam"]}',
                        child: Image.network(
                          d["strTeamBadge"],
                          width: 230,
                        ),

                      )
                    ],
                  )))));

    return listTeamPages;
  }
}