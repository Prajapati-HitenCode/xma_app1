import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xma_app1/Model/user_model.dart';

class UserData {
  static Database? _db;

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "user_dbs.db");
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  void onCreate(Database db, int version) {
    db.execute("CREATE TABLE IF NOT EXISTS user_master("
        "uid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "uname TEXT,"
        "password TEXT,"
        "mno INTEGER,"
        "gender TEXT"
        ");");
  }

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<int> userInsert(user_model user) async {
    var dbReady = await db;
    return await dbReady.insert("user_master", {
      "uname": user.uname,
      "password": user.password,
      "mno": user.mno,
      "gender": user.gender,
    });
  }

  Future<int> userDelete(int uid) async {
    var dbReady = await db;
    return await dbReady.delete(
        "user_master", where: "uid = ?", whereArgs: [uid]);
  }

  Stream<List<user_model>> userSelect() async* {
    var dbReady = await db;
    while (true) {
      List<Map<String, dynamic>> maps = await dbReady.query("user_master");
      yield List.generate(maps.length, (i) {
        return user_model.fromMap(maps[i]);
      });
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<int> userUpdate(user_model user,int uid) async {
    var dbReady = await db;
    return await dbReady.update("user_master", {
      "uname": user.uname,
      "password": user.password,
      "mno": user.mno,
      "gender": user.gender,
    },where: "uid= ?",whereArgs: [uid]);
  }

  Future<bool?> userFound(String username, String password) async {
    var dbReady = await db;
    List<Map<String, dynamic>> results = await dbReady.query("user_master",
        where: "uname = ? AND password = ?", whereArgs: [username, password]);
    return results.isNotEmpty;
  }
}
