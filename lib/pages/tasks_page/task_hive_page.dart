import 'package:flutter/material.dart';
import 'package:secondapp/models/task.dart';
import 'package:secondapp/models/task_hive_model.dart';
import 'package:secondapp/repositories/task_hive_repository.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/show-dialog.dart';
import 'package:secondapp/shared/task_card/task_card_hive.dart';
import 'package:secondapp/shared/textComponent.dart';

class TaksHivePage extends StatefulWidget {
  const TaksHivePage({super.key});

  @override
  State<TaksHivePage> createState() => _TaksHivePageState();
}

class _TaksHivePageState extends State<TaksHivePage> {
  late TaskHiveRepository taskHiveRepository;
  var listTasks = [];
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
    taskHiveRepository = await TaskHiveRepository.load();
    listTasks = taskHiveRepository.getDatas();
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomTitle.buildMainTitle(context, "Página de tarefas"),
          actions: [
            PopupMenuButton<String>(onSelected: (value) async {
              if (value == "tarefas concluidas") {
                //_tasks = taskRepository.completedTasks();
                setState(() {});
              }
              if (value == "tarefas não concluidas") {
                //_tasks = taskRepository.noCompletedTasks();
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
                  return TaskCardHive(
                    task: task,
                    update: (TaskHiveModel taske) {
                      _newTitleControler.text = task.title;
                      ShowAlertDialog.buildDialog(
                          context,
                          "informe o novo título da tarefa",
                          TextField(
                            controller: _newTitleControler,
                          ), () {
                        task.title = _newTitleControler.text;
                        taskHiveRepository.update(task);
                        listarTasks();
                        _newTitleControler.text = "";
                        setState(() {});
                        Navigator.pop(context);
                      });
                    },
                    delete: (TaskHiveModel task) {
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
                                      taskHiveRepository.delete(task);
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
                    concluir: (TaskHiveModel task) {
                      task.finished = !task.finished;
                      taskHiveRepository.finished(task);
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
                                TaskHiveModel newTask = TaskHiveModel.criar(
                                    _titleControler.text, false);
                                listTasks.add(newTask);
                                taskHiveRepository.salvar(newTask);
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
