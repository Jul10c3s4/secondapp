import 'package:flutter/material.dart';

class Task {
  String _title;
  final String _id = UniqueKey().toString();
  bool _finished;

  Task(this._title, this._finished);

  String id() {
    return _id;
  }

  String title() {
    return _title;
  }

  bool finished() {
    return _finished;
  }

  setFinished(bool change) {
    _finished = change;
  }

  setTitle(String change) {
    _title = change;
  }
}
