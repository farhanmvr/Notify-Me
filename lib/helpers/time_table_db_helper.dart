import 'package:sqflite/sqflite.dart' as sql;

import './db_helper.dart';

class TimeTableDBHelper{
  static Future<void> insert(Map<String, dynamic> data) async {
    try {
      var db = await DBHelper.database();
      await db.insert('timetable', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    } catch (err) {
      print(err);
    }
  }

  static Future<List<Map<String, dynamic>>> get timeTable async {
    var db = await DBHelper.database();
    return db.query('timetable');
  }
}