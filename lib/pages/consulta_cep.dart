import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:secondapp/models/cep_model.dart';
import 'package:secondapp/repositories/consulta_cep_repository.dart';
import 'package:secondapp/shared/Custom_buttom.dart';
import 'package:secondapp/shared/custom-textField.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';

class ConsultaCep extends StatefulWidget {
  const ConsultaCep({super.key});

  @override
  State<ConsultaCep> createState() => _ConsultaCepState();
}

class _ConsultaCepState extends State<ConsultaCep> {
  final TextEditingController _cepController =
      TextEditingController(text: "57319100");
  CepModel? cepModel;
  ViaCepRepository viaCepRepository = ViaCepRepository();
  bool load = false;

  void ConsultarCep() async {
    load = true;
    cepModel = null;
    setState(() {});
    _cepController.text.replaceAll(RegExp(r'^0-9'), '');
    cepModel = await viaCepRepository.consultarCep(_cepController.text);
    load = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomTitle.buildMainTitle(context, "CepPage"),
        ),
        drawer: const DrawerComponent(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                  inputType: TextInputType.number,
                  //maxLength: 8,
                  controller: _cepController,
                  hintText: "57319100",
                  title: "Informe seu cep: "),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: CustomButtom(
                    title: CustomTitle.buildTitleButton(context, "Consultar"),
                    color: Colors.green,
                    onPressed: ConsultarCep),
              ),
              const SizedBox(
                height: 5,
              ),
              Visibility(
                  visible: load, child: const CircularProgressIndicator()),
              if (cepModel != null)
                CustomTitle.buildSubTitle(
                    context,
                    "dados de cep: \ncidade: ${cepModel!.localidade}\nbairro: ${cepModel!.bairro}\nuf: ${cepModel!.uf}"
                    "")
            ],
          ),
        ),
      ),
    );
  }
}
