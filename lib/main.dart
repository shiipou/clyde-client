import 'package:flutter/material.dart';
import 'package:let_log/let_log.dart';
import 'package:docker_clyde/pages/logger/logger.dart';
import 'package:docker_clyde/pages/home/home.dart';
import 'package:docker_clyde/pages/not_found/not_found.dart';
import 'package:docker_clyde/pages/setting/settings.dart';
import 'package:docker_clyde/utils/navigation_router.dart';
import 'package:docker_clyde/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(NocturlabClyde());
}

class NocturlabClyde extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Logger.net('Init', type: 'SharedPreferences');
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Logger.endNet('Init',
              type: 'webSocket',
              data: {'event': 'Loaded', 'data': snapshot.data});
          return ChangeNotifierProvider<ThemeManager>(
            create: (BuildContext context) =>
                ThemeManager(storage: snapshot.data),
            child: Consumer<ThemeManager>(
              builder: (context, manager, _) {
                return MaterialApp(
                  title: 'Docker Clyde',
                  theme: manager.themeData,
                  onGenerateRoute: NavigationRouter(context,
                          routes: {
                            '/': (context) =>
                                HomePage(title: 'Home', storage: snapshot.data),
                            '/notifications': (context) => LoggerPage(
                                title: 'Debug', storage: snapshot.data),
                            '/settings': (context) => SettingPage(
                                title: 'Settings', storage: snapshot.data),
                          },
                          notFound: (context) => NotFoundPage(),
                          storage: snapshot.data)
                      .generateRoute,
                );
              },
            ),
          );
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Scaffold(
                  body: Center(
                      child: Text('No connexion !'))); // Must never run this
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
              Logger.endNet('Init',
                  type: 'webSocket',
                  data: {'ConnectionState': 'done', 'data': snapshot.data});
              return Scaffold(body: Center(child: Text('Nothing !')));
              break;
            default:
              return Scaffold(
                  body: Center(
                      child: Text('Unknown state'))); // Must never run this
              break;
          }
        }
      },
    );
  }
}
