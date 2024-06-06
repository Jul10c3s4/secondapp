import 'package:flutter/material.dart';
import 'package:secondapp/models/tarefas_back4app_model.dart';
import 'package:secondapp/models/task.dart';
import 'package:secondapp/models/task_hive_model.dart';
import 'package:secondapp/models/task_sqlite_model.dart';
import 'package:secondapp/shared/textComponent.dart';

class TaskCardHttp extends StatefulWidget {
  TarefaBack4AppModel task;
  Function concluir;
  Function? update;
  Function delete;

  TaskCardHttp(
      {super.key,
      required this.task,
      required this.concluir,
      this.update,
      required this.delete});

  @override
  State<TaskCardHttp> createState() => _TaskCardHttpState();
}

class _TaskCardHttpState extends State<TaskCardHttp> {
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
              CustomTitle.buildTitle(context, widget.task.descricao),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        widget.update!();
                      },
                      icon: const Icon(
                        Icons.update,
                        color: Colors.blue,
                      )),
                  IconButton(
                      onPressed: () {
                        widget.delete();
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
                          value: widget.task.concluido,
                          onChanged: (value) {
                            widget.concluir();
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
