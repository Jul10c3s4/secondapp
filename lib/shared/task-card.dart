import 'package:flutter/material.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:secondapp/models/task.dart';

class TaskCard extends StatelessWidget {
  Task task;
  Function concluir;
  Function? update;
  Function delete;

  TaskCard(
      {super.key,
      required this.task,
      required this.concluir,
      this.update,
      required this.delete});

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
              CustomTitle.buildTitle(context, task.title()),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        update!();
                      },
                      icon: const Icon(
                        Icons.update,
                        color: Colors.blue,
                      )),
                  IconButton(
                      onPressed: () {
                        delete();
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
                          value: task.finished(),
                          onChanged: (value) {
                            concluir();
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
