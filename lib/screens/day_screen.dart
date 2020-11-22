import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../providers/day_subject_list.dart';
import '../widgets/timeTableScreen/day_body.dart';

class DayScreen extends StatelessWidget {
  final Day day;
  const DayScreen({Key key, this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final daySubData = Provider.of<DaySubjects>(context);
    var sub;
    switch (day.value) {
      case 1:
        sub = daySubData.sunSub;
        break;
      case 2:
        sub = daySubData.monSub;
        break;
      case 3:
        sub = daySubData.tueSub;
        break;
      case 4:
        sub = daySubData.wedSub;
        break;
      case 5:
        sub = daySubData.thuSub;
        break;
      case 6:
        sub = daySubData.friSub;
        break;
      case 7:
        sub = daySubData.satSub;
        break;
    }
    return DayBody(subList: sub);
  }
}
