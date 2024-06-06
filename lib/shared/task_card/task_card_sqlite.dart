import 'package:flutter/material.dart';
import 'package:secondapp/models/task.dart';
import 'package:secondapp/models/task_hive_model.dart';
import 'package:secondapp/models/task_sqlite_model.dart';
import 'package:secondapp/shared/textComponent.dart';

class TaskCardSqlite extends StatefulWidget {
  TaskSqliteModel task;
  Function concluir;
  Function? update;
  Function delete;

  TaskCardSqlite(
      {super.key,
      required this.task,
      required this.concluir,
      this.update,
      required this.delete});

  @override
  State<TaskCardSqlite> createState() => _TaskCardSqliteState();
}

class _TaskCardSqliteState extends State<TaskCardSqlite> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.black,
        elevation: 8,
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.lightGreen,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTitle.buildTitle(context, widget.task.title),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        widget.update!(widget.task);
                      },
                      icon: const Icon(
                        Icons.update,
                        color: Colors.blue,
                      )),
                  IconButton(
                      onPressed: () {
                        widget.delete(widget.task);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      alignment: AlignmentDirectional.center,
                      width: 30,
                      height: 50,
                      child: CheckboxListTile(
                          activeColor: Colors.blue,
                          value: widget.task.finished,
                          onChanged: (value) {
                            widget.concluir(widget.task);
                            setState(() {});
                          }),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
