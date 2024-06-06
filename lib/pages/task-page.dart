import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/show-dialog.dart';
import 'package:secondapp/shared/task-card.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:secondapp/models/task.dart';
import 'package:secondapp/repositories/tasks_repository.dart';

class TaksPage extends StatefulWidget {
  const TaksPage({super.key});

  @override
  State<TaksPage> createState() => _TaksPageState();
}

class _TaksPageState extends State<TaksPage> {
  TaskRepository taskRepository = TaskRepository();
  bool load = false;
  var _tasks = const <Task>[];
  final _titleControler = TextEditingController();
  final TextEditingController _newTitleControler = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    listarTasks();
    super.initState();
  }

  listarTasks() async {
    setState(() {
      load = true;
    });
    var result = await taskRepository.getTasks();
    setState(() {
      load = false;
    });

    _tasks = result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle.buildMainTitle(context, "Página de tarefas"),
        actions: [
          PopupMenuButton<String>(onSelected: (value) async {
            if (value == "tarefas concluidas") {
              _tasks = taskRepository.completedTasks();
              setState(() {});
            }
            if (value == "tarefas não concluidas") {
              _tasks = taskRepository.noCompletedTasks();
              setState(() {});
            }
            if (value == "todas as tarefas") {
              listarTasks();
            }
          }, itemBuilder: (BuildContext bc) {
            return <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                  value: "tarefas concluidas",
                  child:
                      CustomTitle.buildSubTitle(context, "tarefas concluídas")),
              PopupMenuItem<String>(
                  value: "tarefas não concluidas",
                  child: CustomTitle.buildSubTitle(
                      context, "tarefas não concluídas")),
              PopupMenuItem<String>(
                  value: "todas as tarefas",
                  child: CustomTitle.buildSubTitle(context, "todas as tarefas"))
            ];
          })
        ],
      ),
      drawer: const DrawerComponent(),
      body: load == true
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _tasks.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemBuilder: (context, index) {
                var task = _tasks[index];
                return TaskCard(
                  task: task,
                  update: () {
                    ShowAlertDialog.buildDialog(
                        context,
                        "informe o novo título da tarefa",
                        TextField(
                          controller: _newTitleControler,
                        ), () {
                      taskRepository.updateTask(
                          task.id(), _newTitleControler.text);
                      _newTitleControler.text = "";
                      setState(() {});
                      Navigator.pop(context);
                    });
                  },
                  delete: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: CustomTitle.buildTitle(context,
                                "Tem certeza que deseja excluir a task ${task.title()} ?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: CustomTitle.buildCancelTitle(
                                      context, "Cancelar")),
                              TextButton(
                                  onPressed: () {
                                    taskRepository.removeTask(task);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child:
                                      CustomTitle.buildOkTitle(context, "ok"))
                            ],
                          );
                        });
                  },
                  concluir: () {
                    taskRepository.changeTask(task.id(), !(task.finished()));
                    setState(() {});
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: CustomTitle.buildTitle(
                        context, "insira o nome da tarefa abaixo: "),
                    content: TextField(
                      controller: _titleControler,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.task_alt_sharp),
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: CustomTitle.buildCancelTitle(
                              context, "Cancelar")),
                      TextButton(
                          onPressed: () async {
                            if (_titleControler.text == "") {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: CustomTitle.buildSubTitle(context,
                                      "Preencha o campo para adicionar a tarefa!")));
                            } else {
                              setState(() {
                                load = true;
                              });
                              Navigator.pop(context);
                              await taskRepository
                                  .addTask(Task(_titleControler.text, false));
                              load = false;
                              _titleControler.text = "";
                              setState(() {});
                            }
                          },
                          child: CustomTitle.buildOkTitle(context, "Adicionar"))
                    ],
                  );
                });
          }),
    );
  }

  handleUpload(String id, bool change) {}
}
