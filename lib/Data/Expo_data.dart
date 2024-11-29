import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xma_app1/Model/expo_model.dart';

class ExpoData {
  static Database? _db;

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "project_db.db");
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  void onCreate(Database db, int version) {
    db.execute("CREATE TABLE IF NOT EXISTS expo_master("
        "eid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "ename varchar2(20),"
        "description varchar2(50),"
        "available INTEGER(10)"
        ");");
  }

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<int> expoInsert(expo_model expo) async {
    var dbReady = await db;
    return await dbReady.insert("expo_master", {
      "ename": expo.ename,
      "description": expo.description,
      "available": expo.available,
    });
  }
  Future<int> expoDelete(int eid) async {
    var dbReady = await db;
    return await dbReady.delete("expo_master", where: "eid = ?", whereArgs: [eid]);
  }
  Stream<List<expo_model>> expoSelect() async* {
    var dbReady = await db;
    while (true) {
      List<Map<String, dynamic>> maps = await dbReady.query("expo_master");
      yield List.generate(maps.length, (i) {
        return expo_model.fromMap(maps[i]);
      });
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
  Future<int> expoUpdate(expo_model expo,int eid) async {
    var dbReady = await db;
    return await dbReady.update("expo_master", {
      "ename": expo.ename,
      "description": expo.description,
      "available": expo.available,
    },where: "eid= ?",whereArgs: [eid]);
  }
  Future <int> expoparticipate(int eid,int noofbooth) async
  {
    var dbReady = await db;
    return await dbReady.update("expo_master", {
      "available": noofbooth,
    },where: "eid= ?",whereArgs: [eid]);
  }
  Future<int> getAvailableBooths(int eid) async {
    var dbReady = await db;
    var result = await dbReady.query(
      "expo_master",
      columns: ["available"],
      where: "eid = ?",
      whereArgs: [eid],
    );
    return result.first["available"] as int; // Cast to int and return 0 if null
  }
}