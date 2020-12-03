import 'package:flutter/material.dart';

import '../widgets/settingsScreen/body.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Body(),
    );
  }
}
