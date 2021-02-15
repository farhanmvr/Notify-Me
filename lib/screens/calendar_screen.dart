import 'package:flutter/material.dart';

import '../widgets/calendarScreen/body.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = '/calendar';
  @override
  Widget build(BuildContext context) {
    final subId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar view'),
      ),
      body: Body(subId),
    );
  }
}
