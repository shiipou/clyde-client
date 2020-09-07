import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationRouter {
  NavigationRouter(this.context, {this.routes, this.notFound, this.storage});

  Map<String, WidgetBuilder> routes;
  WidgetBuilder notFound;
  BuildContext context;
  SharedPreferences storage;

  Route<T> generateRoute<T>(RouteSettings settings) {
    ModalRoute router = ModalRoute.of(context);
    if (router != null) {
      if (router.settings.name == settings.name) {
        return null;
      }
    }

    Widget Function(BuildContext, Animation<double>, Animation<double>)
        pageBuilder;
    if (this.routes.containsKey(settings.name)) {
      pageBuilder = (_, __, ___) => this.routes[settings.name](this.context);
    } else {
      pageBuilder = (_, __, ___) => this.notFound(this.context);
    }

    return PageRouteBuilder(
        pageBuilder: pageBuilder,
        settings: settings,
        maintainState: true,
        transitionsBuilder: (_, anim, __, child) {
          return FadeTransition(opacity: anim, child: child);
        });
  }
}
