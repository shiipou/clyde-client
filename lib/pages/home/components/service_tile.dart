import 'package:flutter/material.dart';
import 'package:docker_clyde/models/service.dart';

class ServiceTile extends StatefulWidget {
  ServiceTile({Key key, this.data}) : super(key: key);

  final ServiceModel data;

  @override
  _ServiceTileState createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: new Text(widget.data.displayName),
      footer: new Text(widget.data.hostName),
    );
  }
}
