import 'package:flutter/material.dart';

import '../widgets/settingsScreen/appearanceScreen/body.dart';

class AppearenceScreen extends StatelessWidget {
  static const routeName = '/appearance';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appearance')),
      body: Body(),
    );
  }
}
