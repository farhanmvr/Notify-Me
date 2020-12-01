import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DaySubject {
  String id;
  String subId;
  Day day;
  TimeOfDay time;

  DaySubject({this.id, this.subId, this.day, this.time});
}
