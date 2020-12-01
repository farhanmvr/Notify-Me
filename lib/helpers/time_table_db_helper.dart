import 'package:sqflite/sqflite.dart' as sql;

import './db_helper.dart';

class TimeTableDBHelper {
  static Future<void> insert(Map<String, dynamic> data) async {
    try {
      var db = await DBHelper.database();
      await db.insert('timetable', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    } catch (err) {
      print(err);
    }
  }

  static Future<List<Map<String, dynamic>>> getNotificationIds(String subId) async {
    final db = await DBHelper.database();
    return db.rawQuery('SELECT id FROM timetable WHERE subId = ?', [subId]);
  }

  static Future<List<Map<String, dynamic>>> get timeTable async {
    final db = await DBHelper.database();
    return db.query('timetable');
  }

  static Future<void> deleteBySubId(String id) async {
    final db = await DBHelper.database();
    await db.rawDelete('DELETE FROM timetable WHERE subId = ?', [id]);
  }

  static Future<void> deleteById(String id) async {
    final db = await DBHelper.database();
    await db.rawDelete('DELETE FROM timetable WHERE id = ?', [id]);
  }
}
