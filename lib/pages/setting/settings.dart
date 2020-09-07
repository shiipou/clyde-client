import 'package:flutter/material.dart';
import 'package:docker_clyde/pages/drawer/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/theme.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key key, this.storage, this.title}) : super(key: key);

  final SharedPreferences storage;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(this.title)),
      ),
      body: NavigationDrawer(child: ThemeSettings()),
    );
  }
}
