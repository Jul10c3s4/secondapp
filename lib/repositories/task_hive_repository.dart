import 'package:hive/hive.dart';
import 'package:secondapp/models/task_hive_model.dart';

class TaskHiveRepository {
  static late Box _box;
  static const String CHAVE_TASKS = "CHAVE_TASKS";

  TaskHiveRepository._create();

  static Future<TaskHiveRepository> load() async {
    if (Hive.isBoxOpen(CHAVE_TASKS)) {
      _box = Hive.box(CHAVE_TASKS);
    } else {
      _box = await Hive.openBox(CHAVE_TASKS);
    }

    return TaskHiveRepository._create();
  }

  void salvar(TaskHiveModel taskHiveModel) {
    _box.add(taskHiveModel);
  }

  void finished(TaskHiveModel taskHiveModel) {
    taskHiveModel.save();
  }

  void update(TaskHiveModel taskHiveModel) {
    taskHiveModel.save();
  }

  void delete(TaskHiveModel taskHiveModel) {
    taskHiveModel.delete();
  }

  List getDatas() {
    return _box.values.cast<TaskHiveModel>().toList();
  }
}
