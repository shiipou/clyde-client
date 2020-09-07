import 'package:flutter/material.dart';

class DockerImageModel {
  DockerImageModel({this.owner, @required this.name, this.tag, this.sha256});

  String owner;
  String name;
  String tag;
  String sha256;
}
