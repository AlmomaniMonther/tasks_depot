import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

import '../models/task.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'tasks.dp'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE todo(id TEXT PRIMARY KEY,title TEXT,description TEXT,dateTime INTEGER,isDone INTEGER,date INTEGER,image TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert('todo', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(int date) async {
    final db = await DBHelper.database();
    var data = await db.query('todo', where: 'date = ?', whereArgs: [date]);
    db.close();
    return data;
  }

  static Future<void> deleteData(String id) async {
    final db = await DBHelper.database();
    await db.delete('todo', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> updateData(String id, bool isDone) async {
    final db = await DBHelper.database();
    await db.rawUpdate('UPDATE todo SET isDone = ? WHERE id = ?',
        [isDone == true ? 1 : 0, id]);
  }
}
