import 'package:flutter/material.dart';
import 'package:secondapp/shared/custom-textField.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/show-dialog.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesSharedPreferencesPage extends StatefulWidget {
  const ConfiguracoesSharedPreferencesPage({super.key});

  @override
  State<ConfiguracoesSharedPreferencesPage> createState() =>
      _ConfiguracoesSharedPreferencesPageState();
}

class _ConfiguracoesSharedPreferencesPageState
    extends State<ConfiguracoesSharedPreferencesPage> {
  final TextEditingController _userNameControler =
      TextEditingController(text: "");
  final TextEditingController _alturaControler =
      TextEditingController(text: "");
  late double altura;
  bool activePushNotification = false;
  bool modeDark = false;

  final CHAVE_USERNAME = "user_name";
  final CHAVE_ALTURA = "altura";
  final CHAVE_ACTIVEPUSHNOTIFICATION = "active_push_notification";
  final CHAVE_MODE_DARK = "mode_dark";
  late SharedPreferences storage;

  @override
  void initState() {
    // TODO: implement initState
    initValues();
    super.initState();
  }

  initValues() async {
    storage = await SharedPreferences.getInstance();
    _userNameControler.text = storage.getString(CHAVE_USERNAME) ?? "";
    altura = storage.getDouble(CHAVE_ALTURA) ?? 0;
    activePushNotification =
        storage.getBool(CHAVE_ACTIVEPUSHNOTIFICATION) ?? false;
    modeDark = storage.getBool(CHAVE_MODE_DARK) ?? false;
    _alturaControler.text = altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerComponent(),
        appBar: AppBar(
          centerTitle: true,
          title: CustomTitle.buildMainTitle(context, "Configurações"),
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
                value: modeDark,
                onChanged: (bool value) {
                  setState(() {
                    modeDark = value;
                  });
                }),
            SwitchListTile(
                title:
                    CustomTitle.buildSubTitle(context, "Ativar notificações"),
                value: activePushNotification,
                onChanged: (bool value) {
                  setState(() {
                    activePushNotification = value;
                  });
                }),
            const SizedBox(
              height: 40,
            ),
            TextButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  try {
                    await storage.setString(
                        CHAVE_USERNAME, _userNameControler.text);
                    await storage.setDouble(
                        CHAVE_ALTURA, double.tryParse(_alturaControler.text)!);
                    await storage.setBool(CHAVE_MODE_DARK, modeDark);
                    await storage.setBool(
                        CHAVE_ACTIVEPUSHNOTIFICATION, activePushNotification);
                    Navigator.pop(context);
                  } catch (e) {
                    ShowAlertDialog.buildDialogOk(
                        context, "Altura em um formato inválido!");
                    return;
                  }
                },
                child: CustomTitle.buildOkTitle(context, "Salvar alterações"))
          ],
        ),
      ),
    );
  }
}
