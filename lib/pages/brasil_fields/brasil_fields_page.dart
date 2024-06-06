import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secondapp/shared/Custom_buttom.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';

class BrasilFieldsPage extends StatefulWidget {
  const BrasilFieldsPage({super.key});

  @override
  State<BrasilFieldsPage> createState() => _BrasilFieldsPageState();
}

class _BrasilFieldsPageState extends State<BrasilFieldsPage> {
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _coinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomTitle.buildMainTitle(context, "Brasil fields"),
        ),
        drawer: const DrawerComponent(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle.buildTitle(context, "Cep:"),
              TextFormField(
                controller: _cepController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // obrigatório
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTitle.buildTitle(context, "Cpf: "),
              TextFormField(
                controller: _cpfController,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  // obrigatório
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTitle.buildTitle(context, "Moeda: "),
              TextFormField(
                controller: _coinController,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  // obrigatório
                  FilteringTextInputFormatter.digitsOnly,
                  CentavosInputFormatter(moeda: true),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: CustomButtom(
                    title: CustomTitle.buildTitleButton(context, "Salvar"),
                    color: Colors.green,
                    onPressed: () {
                      var cpf = CPFValidator.isValid(_cpfController.text);
                      print(cpf);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
