import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqlitedatabase/model/notes.dart';

class DBHelper {
  static Database? _db;
  static const databaseName = 'notes.db';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, databaseName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  closeDatabase() async {
    await _db?.close();
  }

  // create table and all fields
  static const String tblNotes = 'tblNotes';
  static const String id = 'id';
  static const String title = 'title';
  static const String age = 'age';
  static const String description = 'description';
  static const String email = 'email';

  // create table command
  static const String createNotesTbl = "CREATE TABLE ""$tblNotes ("
      "$id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$title TEXT NOT NULL,"
      "$age INTEGER NOT NULL,"
      "$description TEXT NOT NULL,"
      "$email TEXT)";

  /*CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT,"
  "title TEXT NOT NULL,age INTEGER NOT NULL,description TEXT NOT NULL,email TEXT)*/

  _onCreate(Database db, int version) async {
    await db.execute(createNotesTbl);
  }

  // for insertion
  Future<NotesModel> insert(NotesModel notesModel) async {
    var dbClient = await db;
    await dbClient?.insert(tblNotes, notesModel.toMap());
    return notesModel;
  }

  // for selection
  Future<List<NotesModel>> getNoteList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query(tblNotes);
    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }
}
