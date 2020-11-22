import 'dart:async';

import 'package:flutter/material.dart';

class SnackBarHelper{
  static void showSnackBar(BuildContext context,String text, Color color) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: color,
      duration: Duration(seconds: 1),
    ));
    Timer(Duration(seconds: 2), () {
      Scaffold.of(context).hideCurrentSnackBar();
    });
  }
}