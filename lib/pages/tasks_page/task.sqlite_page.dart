import 'package:flutter/material.dart';
import 'package:secondapp/models/task_sqlite_model.dart';
import 'package:secondapp/repositories/sqlite/task_sqlite_repository.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/show-dialog.dart';
import 'package:secondapp/shared/task_card/task_card_sqlite.dart';
import 'package:secondapp/shared/textComponent.dart';

class TaksSqlitePage extends StatefulWidget {
  const TaksSqlitePage({super.key});

  @override
  State<TaksSqlitePage> createState() => _TaksSqlitePageState();
}

class _TaksSqlitePageState extends State<TaksSqlitePage> {
  TaskSqliteRepository taskSqliteRepository = TaskSqliteRepository();
  var listTasks = <TaskSqliteModel>[];
  bool load = false;
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
    listTasks = await taskSqliteRepository.getDatas();
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              CustomTitle.buildMainTitle(context, "Página de tarefas sqlite"),
          actions: [
            PopupMenuButton<String>(onSelected: (value) async {
              if (value == "tarefas concluidas") {
                listTasks = await taskSqliteRepository.customGetDatas(true);
                setState(() {});
              }
              if (value == "tarefas não concluidas") {
                listTasks = await taskSqliteRepository.customGetDatas(false);
                setState(() {});
              }
              if (value == "todas as tarefas") {
                listarTasks();
              }
            }, itemBuilder: (BuildContext bc) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                    value: "tarefas concluidas",
                    child: CustomTitle.buildSubTitle(
                        context, "tarefas concluídas")),
                PopupMenuItem<String>(
                    value: "tarefas não concluidas",
                    child: CustomTitle.buildSubTitle(
                        context, "tarefas não concluídas")),
                PopupMenuItem<String>(
                    value: "todas as tarefas",
                    child:
                        CustomTitle.buildSubTitle(context, "todas as tarefas"))
              ];
            })
          ],
        ),
        drawer: const DrawerComponent(),
        body: load == true
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: listTasks.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                itemBuilder: (context, index) {
                  var task = listTasks[index];
                  return TaskCardSqlite(
                    task: task,
                    update: (TaskSqliteModel taske) {
                      _newTitleControler.text = task.title;
                      ShowAlertDialog.buildDialog(
                          context,
                          "informe o novo título da tarefa",
                          TextField(
                            controller: _newTitleControler,
                          ), () {
                        task.title = _newTitleControler.text;
                        taskSqliteRepository.update(task);
                        listarTasks();
                        _newTitleControler.text = "";
                        setState(() {});
                        Navigator.pop(context);
                      });
                    },
                    delete: (TaskSqliteModel task) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: CustomTitle.buildTitle(context,
                                  "Tem certeza que deseja excluir a task ${task.title} ?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: CustomTitle.buildCancelTitle(
                                        context, "Cancelar")),
                                TextButton(
                                    onPressed: () {
                                      taskSqliteRepository.delete(task.id);
                                      listarTasks();
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child:
                                        CustomTitle.buildOkTitle(context, "ok"))
                              ],
                            );
                          });
                    },
                    concluir: (TaskSqliteModel task) {
                      task.finished = !task.finished;
                      taskSqliteRepository.save(task);
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
                                taskSqliteRepository.save(TaskSqliteModel(
                                    0, _titleControler.text, false));
                                listarTasks();
                                load = false;
                                _titleControler.text = "";
                                setState(() {});
                              }
                            },
                            child:
                                CustomTitle.buildOkTitle(context, "Adicionar"))
                      ],
                    );
                  });
            }),
      ),
    );
  }

  handleUpload(String id, bool change) {}
}
