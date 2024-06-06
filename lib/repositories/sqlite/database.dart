import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  //as aspas triplas indicam que o programa aceitará múltiplas linhas
  1: ''' CREATE TABLE tarefas (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao TEXT,
          concluido INTEGER
          );'''
};

class SqliteDatabase {
  static Database? db;

  Future<Database> getDatabase() async {
    if (db == null) {
      return await initDataBase();
    } else {
      return db!;
    }
  }

  Future<Database> initDataBase() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: scripts.length, onCreate: (db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    }, onUpgrade: (db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    });
    return db;
  }
}
