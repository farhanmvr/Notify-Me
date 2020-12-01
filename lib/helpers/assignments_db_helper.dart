import 'package:sqflite/sqflite.dart' as sql;

import './db_helper.dart';

class AssignmentsDBHelper {
  static Future<void> insert(Map<String, dynamic> data) async {
      var db = await DBHelper.database();
      await db.insert('assignments', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> get assignments async {
    final db = await DBHelper.database();
    return db.query('assignments');
  }

  static Future<void> deleteById(String id) async {
    final db = await DBHelper.database();
    await db.rawDelete('DELETE FROM assignments WHERE id = ?',[id]);
  }

  static Future<List<Map<String, dynamic>>> getNotificationIds(String subId) async {
    final db = await DBHelper.database();
    return db.rawQuery('SELECT id FROM assignments WHERE subId = ?', [subId]);
  }

  static Future<void> deleteBySubId(String id) async {
    final db = await DBHelper.database();
    await db.rawDelete('DELETE FROM assignments WHERE subId = ?', [id]);
  }
}
