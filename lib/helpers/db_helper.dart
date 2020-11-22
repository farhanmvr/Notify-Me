import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'subjects.db'),
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE subjects (id TEXT PRIMARY KEY, name TEXT)');
        await db.execute(
        'CREATE TABLE timetable (id TEXT PRIMARY KEY, subId TEXT, name TEXT, day INTEGER, time TEXT)');
      },
      version: 1,
    );
  }
}
