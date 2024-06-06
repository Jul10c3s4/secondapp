import 'package:secondapp/models/task.dart';

class TaskRepository {
  final List<Task> _tasks = [Task("correr", false)];

  Future<List<Task>> getTasks() async {
    await Future.delayed(const Duration(seconds: 3));
    return _tasks;
  }

  addTask(Task task) async {
    await Future.delayed(const Duration(seconds: 2));
    return _tasks.add(task);
    //return tasks;
  }

  changeTask(String id, bool change) {
    _tasks.where((task) => task.id() == id).first.setFinished(change);
  }

  updateTask(String id, String newTitle) {
    _tasks.where((task) => task.id() == id).first.setTitle(newTitle);
  }

  removeTask(Task task) {
    _tasks.remove(task);
  }

  completedTasks() {
    return _tasks.where((task) => task.finished() == true).toList();
  }

  noCompletedTasks() {
    return _tasks.where((task) => task.finished() == false).toList();
  }
}
