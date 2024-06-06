import 'package:secondapp/models/task_sqlite_model.dart';
import 'package:secondapp/repositories/sqlite/database.dart';

class TaskSqliteRepository {
  Future<List<TaskSqliteModel>> getDatas() async {
    List<TaskSqliteModel> tasks = [];

    var db = await SqliteDatabase().getDatabase();
    var result =
        await db.rawQuery("SELECT id, descricao, concluido FROM tarefas");
    for (var task in result) {
      tasks.add(TaskSqliteModel(int.parse(task["id"].toString()),
          task["descricao"].toString(), task["concluido"] == 1));
    }
    return tasks;
  }

  Future<List<TaskSqliteModel>> customGetDatas(bool onlyCompletedes) async {
    List<TaskSqliteModel> tasks = [];

    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery(onlyCompletedes == false
        ? "SELECT id, descricao, concluido FROM tarefas WHERE concluido = 0"
        : "SELECT id, descricao, concluido FROM tarefas WHERE concluido = 1");
    for (var task in result) {
      tasks.add(TaskSqliteModel(int.parse(task["id"].toString()),
          task["descricao"].toString(), task["concluido"] == 1));
    }
    print(tasks);
    return tasks;
  }

  Future<void> save(TaskSqliteModel taskSqliteModel) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert('INSERT INTO tarefas (descricao, concluido) values(?,?)',
        [taskSqliteModel.title, taskSqliteModel.finished]);
  }

  Future<void> update(TaskSqliteModel taskSqliteModel) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert('''UPDATE tarefas 
                          SET descricao = ?, concluido = ? 
                          WHERE id = ?''',
        [taskSqliteModel.title, taskSqliteModel.finished, taskSqliteModel.id]);
  }

  Future<void> delete(int id) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert('DELETE FROM tarefas WHERE id = ?', [id]);
  }
}
