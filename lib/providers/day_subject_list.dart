import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/day_subject.dart';
import '../helpers/time_table_db_helper.dart';

class DaySubjects with ChangeNotifier {
  List<DaySubject> _monSub = [];
  List<DaySubject> _tueSub = [];
  List<DaySubject> _wedSub = [];
  List<DaySubject> _thuSub = [];
  List<DaySubject> _friSub = [];
  List<DaySubject> _satSub = [];
  List<DaySubject> _sunSub = [];

  List<DaySubject> get monSub => [..._monSub];
  List<DaySubject> get tueSub => [..._tueSub];
  List<DaySubject> get wedSub => [..._wedSub];
  List<DaySubject> get thuSub => [..._thuSub];
  List<DaySubject> get friSub => [..._friSub];
  List<DaySubject> get satSub => [..._satSub];
  List<DaySubject> get sunSub => [..._sunSub];

  void addSubject({Day day, DaySubject subject}) {
    switch (day.value) {
      case 1:
        _sunSub.add(subject);
        break;
      case 2:
        _monSub.add(subject);
        break;
      case 3:
        _tueSub.add(subject);
        break;
      case 4:
        _wedSub.add(subject);
        break;
      case 5:
        _thuSub.add(subject);
        break;
      case 6:
        _friSub.add(subject);
        break;
      case 7:
        _satSub.add(subject);
        break;
    }
    notifyListeners();
    DateTime now = DateTime.now();
    final time = DateTime(now.year, now.month, now.day, subject.time.hour, subject.time.minute);
    TimeTableDBHelper.insert({
      'id': subject.id,
      'subId': subject.subId,
      'name': subject.name,
      'day': subject.day.value,
      'time': time.toIso8601String(),
    });
  }

  Future<void> fetchTimeTable() async {
    List<Map<String, dynamic>> subList = await TimeTableDBHelper.timeTable;
    subList.forEach((element) {
      DateTime dateTime = DateTime.parse(element['time']);
      TimeOfDay time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
      DaySubject sub = DaySubject(
        id: element['id'],
        subId: element['subId'],
        name: element['name'],
        day: Day(element['day']),
        time: time,
      );
      switch (sub.day.value) {
        case 1:
          _sunSub.add(sub);
          break;
        case 2:
          _monSub.add(sub);
          break;
        case 3:
          _tueSub.add(sub);
          break;
        case 4:
          _wedSub.add(sub);
          break;
        case 5:
          _thuSub.add(sub);
          break;
        case 6:
          _friSub.add(sub);
          break;
        case 7:
          _satSub.add(sub);
          break;
      }
    });
    notifyListeners();
  }
}
