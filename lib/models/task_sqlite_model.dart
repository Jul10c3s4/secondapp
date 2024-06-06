class TaskSqliteModel {
  int _id = 0;
  String _title = "";
  bool _finished = false;

  TaskSqliteModel(this._id, this._title, this._finished);

  int get id => _id;

  String get title => _title;

  bool get finished => _finished;

  set id(int id) {
    _id = id;
  }

  set finished(bool finished) {
    _finished = finished;
  }

  set title(String title) {
    _title = title;
  }
}
