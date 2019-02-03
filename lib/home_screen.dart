import 'package:flutter/material.dart';
import 'package:flutter_login/about_us_screen.dart';
import 'package:flutter_login/account_screen.dart';
import 'package:flutter_login/list_sports_screen.dart';
import 'package:flutter_login/list_leagues_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.onSignedOut, this.user});
  final FirebaseUser user;
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => HomeScreenState(user);
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenState(this._user);
  final FirebaseUser _user;
  int _currentIndex = 0;
  final List<Widget> _children = [ListSports(), Leagues()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sport'), actions: <Widget>[
        IconButton(
            onPressed: _share, icon: Icon(Icons.share, color: Colors.white)),
        IconButton(
            onPressed: _logOut,
            icon: Icon(Icons.exit_to_app, color: Colors.white)),
        IconButton(
            onPressed: _accountScreen,
            icon: Icon(Icons.account_circle, color: Colors.white)),
      ]),
      body: _children[_currentIndex],
      drawer: Drawer(
        child: ListView(children: <Widget>[
          UserAccountsDrawerHeader( accountEmail: Text(_user.email), ),
          ListTile(title: Text("About us", style: TextStyle(fontSize: 16)), onTap: _aboutUs),
          ListTile(title: Text("Log out", style: TextStyle(fontSize: 16)), onTap: _logOut),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.category),
            title: new Text('Sports'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.equalizer),
            title: new Text('Leagues'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _share() {}

  void _accountScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccoutScreen()),
    );
  }

  void _logOut() {
    widget.onSignedOut();
  }

  void _aboutUs() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutUs()),
    );
  }
}
