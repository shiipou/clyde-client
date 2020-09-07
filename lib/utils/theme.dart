import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  ThemeManager({this.storage}) {
    _loadTheme();
  }

  ThemeData _themeData;
  final _themeDataKey = "theme_preference";
  SharedPreferences storage;

  void _loadTheme() {
    debugPrint("Entered loadTheme()");

    int preferredTheme = 0;
    if (this.storage != null) {
      preferredTheme = this.storage.getInt(_themeDataKey) ?? 0;
    }
    _themeData = appThemeData[AppTheme.values[preferredTheme]];

    notifyListeners();
  }

  /// Use this method on UI to get selected theme.
  ThemeData get themeData {
    if (_themeData == null) {
      _themeData = appThemeData[AppTheme.Black];
    }
    return _themeData;
  }

  /// Sets theme and notifies listeners about change.
  setTheme(AppTheme theme) {
    _themeData = appThemeData[theme];

    // Here we notify listeners that theme changed
    // so UI have to be rebuild
    notifyListeners();
    // Save selected theme into SharedPreferences
    if (this.storage != null) {
      this.storage.setInt(_themeDataKey, AppTheme.values.indexOf(theme));
    }
  }
}

enum AppTheme { Light, Dark, Black, OneDark, Drakula, WinterIsComing }

/// Returns enum value name without enum class name.
String enumName(AppTheme anyEnum) {
  return anyEnum.toString().split('.')[1];
}

final appThemeData = {
  AppTheme.Light: ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    highlightColor: Colors.transparent.withOpacity(0.3),
    textTheme: ThemeData.light().textTheme.copyWith(
        button: ThemeData.light()
            .textTheme
            .button
            .copyWith(color: Colors.black, fontSize: 22)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  AppTheme.Dark: ThemeData.dark().copyWith(
    primaryColor: Color(0xFF242A31),
    highlightColor: Colors.transparent.withOpacity(0.3),
    backgroundColor: Color(0xFF242A31),
    scaffoldBackgroundColor: Color(0xFF1F242A),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  AppTheme.OneDark: ThemeData.dark().copyWith(
    primaryColor: Color(0xFF282c34),
    highlightColor: Colors.transparent.withOpacity(0.3),
    backgroundColor: Color(0xFF282c34),
    scaffoldBackgroundColor: Color(0xFF282c34),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  AppTheme.Black: ThemeData.dark().copyWith(
    primaryColor: Color(0xFF141414),
    highlightColor: Colors.black,
    backgroundColor: Color(0xFF141414),
    accentColor: Color(0xFF8B90A5),
    floatingActionButtonTheme: ThemeData.dark()
        .floatingActionButtonTheme
        .copyWith(
            backgroundColor: Color(0xFF40424E), foregroundColor: Colors.black),
    scaffoldBackgroundColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  AppTheme.Drakula: ThemeData.dark().copyWith(
    primaryColor: Color(0xFF21222c),
    highlightColor: Colors.transparent.withOpacity(0.3),
    backgroundColor: Color(0xFF343746),
    scaffoldBackgroundColor: Color(0xFF282a36),
    accentColor: Color(0xFF191a21),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  AppTheme.WinterIsComing: ThemeData.light().copyWith(
    primaryColor: Color(0xFF112233),
    backgroundColor: Color(0xFF2c2c2c),
    highlightColor: Colors.transparent.withOpacity(0.3),
    scaffoldBackgroundColor: Color(0xFFffffff),
    accentColor: Color(0xFF2f85d2),
    textTheme: ThemeData.light().textTheme.copyWith(
        button: ThemeData.light()
            .textTheme
            .button
            .copyWith(color: Colors.white, fontSize: 22)),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
};
