import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.onSignedOut});
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _count = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('Home Screen'), actions: <Widget>[
              IconButton(
                  onPressed: logOut,
                  icon: Icon(Icons.reply, color: Colors.white)),
              IconButton(
                  onPressed: share,
                  icon: Icon(Icons.share, color: Colors.white)),
            ]),
            body: ListView.builder(
                itemCount: _count,
                itemBuilder: (BuildContext context, _count) {
                  return ListTile(
                    subtitle: const Text('Sub Title'),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue,
                    ),
                    leading: const Icon(
                      Icons.stars,
                      color: Colors.blue,
                    ),
                    title: const Text('Title'),
                  );
                }));
  }

  void share() {}

  void logOut() {
    widget.onSignedOut();
  }
}
