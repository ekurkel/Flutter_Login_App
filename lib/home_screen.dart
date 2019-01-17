import 'package:flutter/material.dart';
import 'package:flutter_login/account_screen.dart';
import 'package:flutter_login/list_sports_screen.dart';
import 'package:flutter_login/list_leagues_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.onSignedOut});
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [ListSports(), Leagues()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sport'), actions: <Widget>[
        IconButton(
            onPressed: share, icon: Icon(Icons.share, color: Colors.white)),
        IconButton(
            onPressed: logOut,
            icon: Icon(Icons.exit_to_app, color: Colors.white)),
        IconButton(
            onPressed: account,
            icon: Icon(Icons.account_circle, color: Colors.white)),
      ]),
      body: _children[_currentIndex],
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

  void share() {}

  void account() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccoutScreen()),
    );
  }

  void logOut() {
    widget.onSignedOut();
  }
}
