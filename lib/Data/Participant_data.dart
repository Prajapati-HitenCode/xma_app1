import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xma_app1/Model/participant_model.dart';

class Participantdata {
  static Database? _db;

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "particpant_db.db");
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  void onCreate(Database db, int version) {
    db.execute("CREATE TABLE IF NOT EXISTS participant("
        "pid INTEGER PRIMARY KEY AUTOINCREMENT,"
        "pname varchar2(20),"
        "no_of_booth INTEGER(2),"
        "no_of_member INTEGER(2),"
        "pmno INTEGER(10)"
        ");");
  }

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<int> participantInsert(participant_model participant) async {
    var dbReady = await db;
    return await dbReady.insert("participant", {
      "pname": participant.pname,
      "no_of_booth": participant.no_of_booth,
      "no_of_member": participant.no_of_member,
      "pmno": participant.pmno,
    });
  }
  Future<int> participantDelete(int pid) async {
    var dbReady = await db;
    return await dbReady.delete("participant", where: "pid = ?", whereArgs: [pid]);
  }

  Stream<List<participant_model>> participantSelect() async* {
    var dbReady = await db;
    while (true) {
      List<Map<String, dynamic>> maps = await dbReady.query("participant");
      yield List.generate(maps.length, (i) {
        return participant_model.fromMap(maps[i]);
      });
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<int> participantUpdate(participant_model participant,int pid) async {
    var dbReady = await db;
    return await dbReady.update("participant", {
      "pname": participant.pname,
      "no_of_booth": participant.no_of_booth,
      "no_of_member": participant.no_of_member,
      "pmno": participant.pmno,
    },where: "pid= ?",whereArgs: [pid]);
  }
}
