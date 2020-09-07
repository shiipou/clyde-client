import 'package:flutter/material.dart';
import 'package:docker_clyde/models/service.dart';

class UserModel {
  UserModel(
      {@required this.id,
      @required this.displayName,
      List<ServiceModel> services}) {
    this.services = services ?? [];
  }

  String id;
  String displayName;
  List<ServiceModel> services;
}
