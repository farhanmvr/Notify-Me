import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../screens/day_screen.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        DayScreen(day: Day(1)),
        DayScreen(day: Day(2)),
        DayScreen(day: Day(3)),
        DayScreen(day: Day(4)),
        DayScreen(day: Day(5)),
        DayScreen(day: Day(6)),
        DayScreen(day: Day(7)),
      ],
    );
  }
}
