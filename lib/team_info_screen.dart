import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_login/model/team.dart';

class TeamInfo extends StatelessWidget {
  final Team _team;

  TeamInfo(this._team);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_team.teamName)),
        body: Container(
            alignment: Alignment.center,
            child: ListView(children: <Widget>[
              Column(children: <Widget>[
                SizedBox(height: 20),
                SizedBox(
                    height: 200.0,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: <
                            Widget>[
                      Row(children: <Widget>[
                        Hero(
                            tag: 'imageTeamHero${_team.teamName}',
                            child: Image.network(_team.picture, width: 150)),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _team.website.length != 0
                                  ? Row(children: <Widget>[
                                      Image.network(
                                          "https://img.icons8.com/metro/1600/domain.png",
                                          width: 30),
                                      FlatButton(
                                          onPressed: () {
                                            loadWebSite(_team.website);
                                          },
                                          child: Text(_team.website,
                                              style: TextStyle(fontSize: 16)))
                                    ])
                                  : SizedBox(height: 0),
                              _team.instagtam.length != 0
                                  ? Row(children: <Widget>[
                                      Image.network(
                                          "https://instagram-brand.com/wp-content/uploads/2016/11/app-icon2.png",
                                          width: 30),
                                      FlatButton(
                                          onPressed: () {
                                            loadWebSite(_team.instagtam);
                                          },
                                          child: Text(_team.instagtam,
                                              style: TextStyle(fontSize: 16)))
                                    ])
                                  : SizedBox(height: 0),
                              _team.facebook.length != 0
                                  ? Row(children: <Widget>[
                                      Image.network(
                                          "http://www.iconarchive.com/download/i54037/danleech/simple/facebook.ico",
                                          width: 30),
                                      FlatButton(
                                          onPressed: () {
                                            loadWebSite(_team.facebook);
                                          },
                                          child: Text(_team.facebook,
                                              style: TextStyle(fontSize: 16)))
                                    ])
                                  : SizedBox(height: 0),
                              _team.youtube.length != 0
                                  ? Row(children: <Widget>[
                                      Image.network(
                                          "https://cdn0.iconfinder.com/data/icons/social-flat-rounded-rects/512/youtube_v2-512.png",
                                          width: 30),
                                      FlatButton(
                                          onPressed: () {
                                            loadWebSite(_team.youtube);
                                          },
                                          child: Text(_team.youtube,
                                              style: TextStyle(fontSize: 16)))
                                    ])
                                  : SizedBox(height: 0),
                            ])
                      ])
                    ])),
                SizedBox(height: 20),
                Text(
                  _team.teamName,
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(_team.teamDescription,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify)),

              ])
            ])));
  }

  void loadWebSite(String url) async {
    if (await canLaunch("http://$url")) {
      await launch("http://$url");
    } else {
      throw 'Could not launch $url';
    }
  }
}
