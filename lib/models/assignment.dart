import 'package:flutter/material.dart';

class Assignment {
  String id;
  String subId;
  String title;
  String description;
  DateTime date;
  TimeOfDay time;

  Assignment({
    this.id,
    this.subId,
    this.title,
    this.date,
    this.description,
    this.time,
  });
}
