import 'package:flutter/material.dart';
import 'package:secondapp/models/tarefas_back4app_model.dart';
import 'package:secondapp/models/task_sqlite_model.dart';
import 'package:secondapp/repositories/back4app/tarefas_back4app_dio_repository.dart';
import 'package:secondapp/repositories/sqlite/task_sqlite_repository.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/show-dialog.dart';
import 'package:secondapp/shared/task_card/task_card_http.dart';
import 'package:secondapp/shared/task_card/task_card_sqlite.dart';
import 'package:secondapp/shared/textComponent.dart';

class TarefaHttpPage extends StatefulWidget {
  const TarefaHttpPage({super.key});

  @override
  State<TarefaHttpPage> createState() => _TarefaHttpPageState();
}

class _TarefaHttpPageState extends State<TarefaHttpPage> {
  TarefasBack4AppRepository taskHttpRepository = TarefasBack4AppRepository();
  TarefasBack4AppModel listTasks =
      TarefasBack4AppModel(<TarefaBack4AppModel>[]);
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
    listTasks = await taskHttpRepository.getTarefas();
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomTitle.buildMainTitle(context, "Página de tarefas Http"),
          actions: [
            PopupMenuButton<String>(onSelected: (value) async {
              if (value == "tarefas concluidas") {
                listTasks =
                    await taskHttpRepository.getTarefasCompleOrUncople(true);
                setState(() {});
              }
              if (value == "tarefas não concluidas") {
                listTasks =
                    await taskHttpRepository.getTarefasCompleOrUncople(false);
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
                itemCount: listTasks.taferas.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                itemBuilder: (context, index) {
                  var task = listTasks.taferas[index];
                  return TaskCardHttp(
                    task: task,
                    update: () {
                      _newTitleControler.text = task.descricao;
                      ShowAlertDialog.buildDialog(
                          context,
                          "informe o novo título da tarefa",
                          TextField(
                            controller: _newTitleControler,
                          ), () {
                        task.descricao = _newTitleControler.text;
                        taskHttpRepository.updateTask(
                            task.objectId, task.descricao);
                        listarTasks();
                        _newTitleControler.text = "";
                        setState(() {});
                        Navigator.pop(context);
                      });
                    },
                    delete: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: CustomTitle.buildTitle(context,
                                  "Tem certeza que deseja excluir a task ${task.descricao} ?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: CustomTitle.buildCancelTitle(
                                        context, "Cancelar")),
                                TextButton(
                                    onPressed: () async {
                                      taskHttpRepository
                                          .deleteTask(task.objectId);
                                      listarTasks();
                                      Navigator.pop(context);
                                    },
                                    child:
                                        CustomTitle.buildOkTitle(context, "ok"))
                              ],
                            );
                          });
                    },
                    concluir: () async {
                      taskHttpRepository.completeTask(
                          task.objectId, !task.concluido);
                      listarTasks();
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
                                await taskHttpRepository.createTask(
                                    TarefaBack4AppModel.create(
                                        _titleControler.text, false));
                                Navigator.pop(context);
                                listarTasks();
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
