import 'package:flutter/material.dart';
import 'package:docker_clyde/pages/drawer/drawer.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Error 404')),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 80.0, right: 8.0, top: 8.0, bottom: 8.0),
          child: Center(child: Text('Page not found')),
        ),
        NavigationDrawer(),
      ]),
    );
  }
}
