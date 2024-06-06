import 'package:hive/hive.dart';

part 'task_hive_model.g.dart';

@HiveType(typeId: 1)
class TaskHiveModel extends HiveObject {
  @HiveField(0)
  String title = "";

  @HiveField(1)
  bool finished = false;

  TaskHiveModel();

  TaskHiveModel.criar(this.title, this.finished);
}
