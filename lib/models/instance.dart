import 'package:flutter/material.dart';
import 'package:docker_clyde/models/docker_image.dart';
import 'package:docker_clyde/models/network.dart';

class InstanceModel {
  InstanceModel({
    @required this.id,
    this.hostName,
    @required this.image,
    this.command,
    List<String> ports,
    this.creationDate,
    List<NetworkModel> networks,
    Map<String, String> labels,
  }) {
    this.ports = ports ?? [];
    this.networks = networks ?? [];
    this.labels = labels ?? [];
  }

  String id;
  String hostName;
  DockerImageModel image;
  String command;
  DateTime creationDate;

  List<String> ports;
  List<NetworkModel> networks;
  Map<String, String> labels;
}
