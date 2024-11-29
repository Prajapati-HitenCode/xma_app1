import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xma_app1/Model/admin_model.dart';

class AdminData {
  static Database? _db;

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "master_db.db");
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  void onCreate(Database db, int version) {
    db.execute("CREATE TABLE IF NOT EXISTS admin_master("
        "aid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "aname TEXT ,"
        "password TEXT,"
        ");");
  }

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<int> adminInsert(admin_model admin) async {
    var dbReady = await db;
    return await dbReady.insert("admin_master", {
      "aname": admin.aname,
      "password": admin.password,
    });
  }

  Future<bool?> adminFound(String username, String password) async {
    var dbReady = await db;
    List<Map<String, dynamic>> results = await dbReady.query("admin_master",
        where: "aname = ? AND password = ?", whereArgs: [username, password]);
    return results.isNotEmpty;
  }
  Future<void> insertDataIntoDb() async {
    final adminExists = await AdminData().adminExists("hiten");
    if (!adminExists) {
      admin_model admin = admin_model(aname: "hiten", password: "hiten12345");
      await AdminData().adminInsert(admin);
      }
    }
  Future<bool> adminExists(String username) async {
    try {
      var dbReady = await db;
      List<Map<String, dynamic>> results = await dbReady.query("admin_master",
          where: "aname = ?", whereArgs: [username]);
      return results.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking if admin exists: $e');
      return false;
    }
  }
}
