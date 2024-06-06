import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:secondapp/models/cofiguracoes_model.dart';
import 'package:secondapp/repositories/configuracoes_repository.dart';
import 'package:secondapp/shared/custom-textField.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/show-dialog.dart';
import 'package:secondapp/shared/textComponent.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({super.key});

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {
  final TextEditingController _userNameControler =
      TextEditingController(text: "");
  final TextEditingController _alturaControler =
      TextEditingController(text: "");

  late ConfiguracoesRepository configuracoesRepository;
  ConfiguracoesModel configuracoesModel = ConfiguracoesModel.empty();

  @override
  void initState() {
    // TODO: implement initState
    initValues();
    super.initState();
  }

  initValues() async {
    configuracoesRepository = await ConfiguracoesRepository.load();
    configuracoesModel = configuracoesRepository.getDatas();
    _userNameControler.text = configuracoesModel.userName;
    _alturaControler.text = configuracoesModel.height.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerComponent(),
        appBar: AppBar(
          centerTitle: true,
          title: CustomTitle.buildMainTitle(context, "configuracoes Hive"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomTextField(
                      controller: _userNameControler,
                      hintText: "julio",
                      title: "Insira o nome de usuário:"),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                      inputType: TextInputType.number,
                      title: "Insira a altura: ",
                      controller: _alturaControler,
                      hintText: "1.80"),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SwitchListTile(
                title: CustomTitle.buildSubTitle(context, "Modo dark"),
                value: configuracoesModel.darkTheme,
                onChanged: (bool value) {
                  setState(() {
                    configuracoesModel.darkTheme = value;
                  });
                }),
            SwitchListTile(
                title:
                    CustomTitle.buildSubTitle(context, "Ativar notificações"),
                value: configuracoesModel.receiverNotifications,
                onChanged: (bool value) {
                  setState(() {
                    configuracoesModel.receiverNotifications = value;
                  });
                }),
            const SizedBox(
              height: 40,
            ),
            TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  try {
                    configuracoesModel.height =
                        double.parse(_alturaControler.text);
                  } catch (e) {
                    ShowAlertDialog.buildDialogOk(
                        context, "Altura em um formato inválido!");
                    return;
                  }
                  configuracoesModel.userName = _userNameControler.text;
                  configuracoesRepository.salvar(configuracoesModel);
                  Navigator.pop(context);
                },
                child: CustomTitle.buildOkTitle(context, "Salvar alterações"))
          ],
        ),
      ),
    );
  }
}
