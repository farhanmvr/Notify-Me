import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/day_subject.dart';
import '../helpers/time_table_db_helper.dart';
import '../helpers/notification_helper.dart';

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

  // Get array by day
  List<DaySubject> getSubArray(Day day) {
    switch (day.value) {
      case 1:
        return _sunSub;
      case 2:
        return _monSub;
      case 3:
        return _tueSub;
      case 4:
        return _wedSub;
      case 5:
        return _thuSub;
      case 6:
        return _friSub;
      case 7:
        return _satSub;
    }
  }

  // Get all arrays
  List<List<DaySubject>> getAllArray() {
    return [_sunSub, _monSub, _tueSub, _wedSub, _thuSub, _friSub, _satSub];
  }

  // Add subject
  void addSubject({Day day, DaySubject subject}) {
    final subArray = getSubArray(day);
    subArray.add(subject);
    DateTime now = DateTime.now();
    subArray.sort(
      (a, b) => DateTime(now.year, now.month, now.day, a.time.hour, a.time.minute).compareTo(
        DateTime(now.year, now.month, now.day, b.time.hour, b.time.minute),
      ),
    );
    notifyListeners();
    final time = DateTime(now.year, now.month, now.day, subject.time.hour, subject.time.minute);
    TimeTableDBHelper.insert({
      'id': subject.id,
      'subId': subject.subId,
      'day': subject.day.value,
      'time': time.toIso8601String(),
    });
  }

  // Fetch all subjects
  Future<void> fetchTimeTable() async {
    List<Map<String, dynamic>> subList = await TimeTableDBHelper.timeTable;
    subList.forEach((element) {
      DateTime dateTime = DateTime.parse(element['time']);
      TimeOfDay time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
      DaySubject sub = DaySubject(
        id: element['id'],
        subId: element['subId'],
        day: Day(element['day']),
        time: time,
      );
      final subArray = getSubArray(sub.day);
      subArray.add(sub);
    });
    sort();
    notifyListeners();
  }

  // Delete all subjects by subId
  void deleteBySubId(String id) async {
    _monSub.removeWhere((el) => el.subId == id);
    _tueSub.removeWhere((el) => el.subId == id);
    _wedSub.removeWhere((el) => el.subId == id);
    _thuSub.removeWhere((el) => el.subId == id);
    _friSub.removeWhere((el) => el.subId == id);
    _satSub.removeWhere((el) => el.subId == id);
    _sunSub.removeWhere((el) => el.subId == id);
    notifyListeners();
    // Delete time table Notifications
    final notficationIds = await TimeTableDBHelper.getNotificationIds(id);
    notficationIds.forEach((el) async {
      await NotificationHelper.deleteNotificatons(el['id'].hashCode);
      await NotificationHelper.deleteNotificatons(el['id'].hashCode + 1);
    });
    // Delete from db
    await TimeTableDBHelper.deleteBySubId(id);
  }

  // Delete by ID
  Future<void> deleteById(String id) async {
    _monSub.removeWhere((el) => el.id == id);
    _tueSub.removeWhere((el) => el.id == id);
    _wedSub.removeWhere((el) => el.id == id);
    _thuSub.removeWhere((el) => el.id == id);
    _friSub.removeWhere((el) => el.id == id);
    _satSub.removeWhere((el) => el.id == id);
    _sunSub.removeWhere((el) => el.id == id);
    notifyListeners();
    // Delete Notification
    await NotificationHelper.deleteNotificatons(id.hashCode);
    await NotificationHelper.deleteNotificatons(id.hashCode + 1);
    // Delete from db
    await TimeTableDBHelper.deleteById(id);
  }

  // Sort all arrays
  void sort() {
    DateTime date = DateTime.now();
    getAllArray().forEach((subArray) {
      subArray.sort(
        (a, b) => DateTime(date.year, date.month, date.day, a.time.hour, a.time.minute).compareTo(
          DateTime(date.year, date.month, date.day, b.time.hour, b.time.minute),
        ),
      );
    });
  }
}
