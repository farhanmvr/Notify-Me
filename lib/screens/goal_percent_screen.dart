import 'package:flutter/material.dart';

import '../widgets/settingsScreen/goalPercentScreen/body.dart';

class GoalPercentScreen extends StatelessWidget {
  static const routeName = '/goal-percent';
  final isFirst;
  GoalPercentScreen(this.isFirst);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Goal Percentage'),
      ),
      body: Body(isFirst),
    );
  }
}
