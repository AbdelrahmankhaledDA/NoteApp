import 'package:sqflite/sqflite.dart';

class SqfliteHelper {
  Database? _database;
  get database async {
    if (_database != null) {
      print(" DB is already open");
      return _database!;
    } else {
      _database = await startDb();
      print("DB is open");
      return _database!;
    }
  }

  Future<Database?> startDb() async {
    final dbPath = await getDatabasesPath();
    final currentpath = "$dbPath/mynotes.db";
    return await openDatabase(
      currentpath,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute('''
CREATE TABLE notes(

id INTEGER PRIMARY KEY AUTOINCREMENT,
title TEXT,
desc TEXT
)



''');
      },
    );
  }

  Future insertNotes(String title, String desc) async {
    Database db = await database;
    await db.insert("notes", {"title": title, "desc": desc});
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    Database db = await database;
    return db.query('notes');
  }

  Future deleteNote(int id) async {
    Database db = await database;
    await db.delete('notes', where: 'id=?', whereArgs: [id]);
  }
}
