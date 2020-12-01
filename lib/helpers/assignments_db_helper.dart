import 'package:sqflite/sqflite.dart' as sql;

import './db_helper.dart';

class AssignmentsDBHelper {
  static Future<void> insert(Map<String, dynamic> data) async {
    try {
      var db = await DBHelper.database();
      await db.insert('assignments', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    } catch (err) {
      print(err);
    }
  }

  static Future<List<Map<String, dynamic>>> get assignments async {
    final db = await DBHelper.database();
    return db.query('assignments');
  }

  static Future<void> deleteExpired(String id) async {
    final db = await DBHelper.database();
    await db.rawDelete('DELETE FROM assignments WHERE id = ?',[id]);
  }
}
