import 'package:flutter/material.dart';
import 'package:docker_clyde/pages/drawer/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.storage}) : super(key: key);

  final String title;
  final SharedPreferences storage;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: NavigationDrawer(
        child: Container(
          child: Center(child: Text('Home')),
        ),
      ),
    );
  }
}
