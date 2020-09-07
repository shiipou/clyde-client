import 'package:flutter/material.dart';
import 'package:docker_clyde/pages/home/components/service_tile.dart';

class ServiceGrid extends StatefulWidget {
  ServiceGrid({Key key}) : super(key: key);

  @override
  _ServiceGridState createState() => _ServiceGridState();
}

class _ServiceGridState extends State<ServiceGrid> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is Iterable) {
            List data = snapshot.data;
            return GridView.builder(
              itemCount: data.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 2
                        : 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ServiceTile(data: data[index]);
              },
            );
          } else {
            return Scaffold(
              body: Center(child: Text('Recieved data is corrupted')),
            );
          }
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Scaffold(body: Center(child: Text('No connexion !')));
              break;
            case ConnectionState.waiting:
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            case ConnectionState.active:
              return Scaffold(
                  body: Center(
                      child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.amberAccent),
              )));
              break;
            case ConnectionState.done:
              return Scaffold(body: Center(child: Text('Nothing !')));
              break;
            default:
              return Scaffold(body: Center(child: Text('Unknown state')));
              break;
          }
        }
      },
    );
  }
}
