import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppTheme with ChangeNotifier {
  ThemeData _theme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
  );
  ThemeData get theme => _theme;

  void setLight() {
    _theme = ThemeData(
      primaryColor: Color.fromRGBO(60, 9, 108, 1),
      accentColor: Color.fromRGBO(90, 24, 154, 1),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          title: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
    notifyListeners();
  }
}
