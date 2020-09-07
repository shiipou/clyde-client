import 'package:flutter/material.dart';

class NavigationModel {
  static List<NavigationModel> list = [
    NavigationModel(id: '/', title: 'Home', icon: Icons.home),
    NavigationModel(id: '/my-cloud', title: 'My cloud', icon: Icons.wb_cloudy),
    NavigationModel(
        id: '/notifications',
        title: 'Notifications',
        icon: Icons.notifications),
    NavigationModel(
        id: '/contact', title: 'Contact', icon: Icons.contacts_sharp),
    NavigationModel(id: '/settings', title: 'Settings', icon: Icons.settings)
  ];

  NavigationModel({this.id, this.title, this.icon});

  String id;
  String title;
  IconData icon;
}
