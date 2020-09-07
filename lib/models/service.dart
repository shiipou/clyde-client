import 'package:flutter/material.dart';
import 'package:docker_clyde/models/docker_image.dart';
import 'package:docker_clyde/models/instance.dart';

class ServiceModel {
  ServiceModel(
      {@required this.id,
      @required this.displayName,
      this.creationDate,
      Map<String, String> labels,
      List<InstanceModel> instances}) {
    this.instances = instances ?? [];
    this.labels = labels ?? [];
  }

  String id;
  String displayName;
  String hostName;
  DockerImageModel image;
  String command;
  DateTime creationDate;

  List<String> ports;
  List<InstanceModel> instances;
  Map<String, String> labels;
}
