import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListScreenState();
}

class ListScreenState extends State {
  int _count = 30;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  Scaffold(
          appBar:  AppBar(title:  Text('Flutter')),
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
              }),
        ));
  }
}
