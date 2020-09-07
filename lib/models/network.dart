import 'package:flutter/material.dart';

import 'package:docker_clyde/models/service.dart';

class NetworkModel {
  NetworkModel(
      {@required this.id,
      @required this.displayName,
      this.type,
      List<ServiceModel> services}) {
    this.services = services ?? <ServiceModel>[];
  }

  String id;
  String displayName;
  String type;
  List<ServiceModel> services;
}
