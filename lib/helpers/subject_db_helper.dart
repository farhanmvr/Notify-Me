import 'package:sqflite/sqflite.dart' as sql;

import './db_helper.dart';
import './time_table_db_helper.dart';
import '../models/subject.dart';

class SubjectDBHelper {
  // Insert
  static Future<void> insert(Map<String, dynamic> data) async {
    try {
      var db = await DBHelper.database();
      await db.insert('subjects', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    } catch (err) {
      print(err);
    }
  }

  // Get subjects
  static Future<List<Map<String, dynamic>>> get subjects async {
    var db = await DBHelper.database();
    return db.query('subjects');
  }

  // Edit subject
  static Future<void> editSubject(Subject subject) async {
    final db = await DBHelper.database();
    await db.rawUpdate('UPDATE subjects SET name = ? ,present = ?, absent = ? WHERE id = ?',
        [subject.name, subject.present, subject.absent, subject.id]);
  }

  // Delete
  static Future<void> deleteById(String id) async {
    final db = await DBHelper.database();
    await db.rawDelete('DELETE FROM subjects WHERE id = ?', [id]);
    await TimeTableDBHelper.deleteBySubId(id);
  }

  // Add present
  static Future<void> present(String id) async {
    final db = await DBHelper.database();
    await db.rawUpdate('UPDATE subjects SET present = present + 1 WHERE id = ?', [id]);
  }

  // Add absent
  static Future<void> absent(String id) async {
    final db = await DBHelper.database();
    await db.rawUpdate('UPDATE subjects SET absent = absent + 1 WHERE id = ?', [id]);
  }
}
