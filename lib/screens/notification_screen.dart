import 'package:flutter/material.dart';

import '../widgets/settingsScreen/notificationScreen/body.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = '/notifications';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notfication'),
      ),
      body: Body(),
    );
  }
}
