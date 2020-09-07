import 'package:flutter/material.dart';
import 'package:let_log/let_log.dart';
import 'package:docker_clyde/pages/drawer/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggerPage extends StatelessWidget {
  LoggerPage({Key key, this.storage, this.title}) : super(key: key);

  final String title;
  final SharedPreferences storage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(this.title)),
      ),
      body: NavigationDrawer(child: Logger()),
    );
  }
}
