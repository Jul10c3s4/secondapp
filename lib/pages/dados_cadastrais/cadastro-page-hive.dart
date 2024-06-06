import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:secondapp/models/dados_cadastrais_model.dart';
import 'package:secondapp/repositories/dados_cadastrais_repository.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:secondapp/pages/home_page.dart';
import 'package:secondapp/repositories/linguagens_repositories.dart';
import 'package:secondapp/repositories/nivel_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DadosCadastraisHivePage extends StatefulWidget {
  const DadosCadastraisHivePage({super.key});

  @override
  State<DadosCadastraisHivePage> createState() =>
      _DadosCadastraisHivePageState();
}

class _DadosCadastraisHivePageState extends State<DadosCadastraisHivePage> {
  final _dataNascimentoController = TextEditingController();
  final formatador = DateFormat('dd/MM/yyyy');
  var nivelRepository = NivelRepositorty();
  var niveis = [];
  var linguagens = [];
  var linguaremPrefRepository = LinguagensRepositories();
  bool load = false;

  final _nomeController = TextEditingController();
  String? dataNascimento;

  late DadosCadastraisRepository dadosCadastraisRepository;
  DadosCadastraisModel dadosCadastraisModel = DadosCadastraisModel.empty();

  @override
  void initState() {
    // TODO: implement initState
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguaremPrefRepository.retornarLinguagens();
    getData();
    super.initState();
  }

  getData() async {
    dadosCadastraisRepository = await DadosCadastraisRepository.load();

    dadosCadastraisModel = dadosCadastraisRepository.getDatas();

    _nomeController.text = dadosCadastraisModel.nome ?? "";
    _dataNascimentoController.text = dadosCadastraisModel.dataNascimento ?? "";
    setState(() {});
  }

  List<DropdownMenuItem<int>> returnItens(int maxYears) {
    var items = <DropdownMenuItem<int>>[];
    for (var i = 0; i < maxYears; i++) {
      items.add(DropdownMenuItem(
          alignment: AlignmentDirectional.center,
          value: i,
          child: Text(i.toString())));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerComponent(),
        appBar: AppBar(
          title: CustomTitle.buildMainTitle(context, "Cadastrar dev Hive"),
        ),
        body: load == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                children: [
                  Center(
                    child: CustomTitle.buildTitle(
                        context, "Cadastro de programador"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTitle.buildSubTitle(context, "Nome:"),
                  TextField(
                    controller: _nomeController,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.only(left: 10),
                      hintText: 'Julio',
                      hintStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTitle.buildSubTitle(context, "Data de Nascimento"),
                  TextField(
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                      icon: const Icon(Icons.date_range),
                      onPressed: () async {
                        DateTime? data = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000, 1, 1),
                            lastDate: DateTime(2023, 12, 31));

                        if (data != null) {
                          _dataNascimentoController.text =
                              formatador.format(data);
                        }
                      },
                    )),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: _dataNascimentoController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? data = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000, 1, 1),
                          firstDate: DateTime(2000, 1, 1),
                          lastDate: DateTime(2023, 12, 31));

                      if (data != null) {
                        _dataNascimentoController.text =
                            formatador.format(data);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTitle.buildSubTitle(context, "Nível de experiência"),
                  Column(
                    children: niveis.map((nivel) {
                      return RadioListTile(
                          title: CustomTitle.builddataTitle(context, "$nivel"),
                          value: nivel,
                          selected:
                              dadosCadastraisModel.levelExperience == nivel,
                          groupValue: dadosCadastraisModel.levelExperience,
                          dense: true,
                          onChanged: (value) {
                            setState(() {
                              dadosCadastraisModel.levelExperience =
                                  value.toString();
                            });
                          });
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTitle.buildSubTitle(context, "Liguagens preferidas"),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: linguagens.map((linguagem) {
                      return CheckboxListTile(
                          dense: true,
                          title: CustomTitle.builddataTitle(context, linguagem),
                          value: dadosCadastraisModel.choosedLanguages
                              .contains(linguagem),
                          onChanged: (value) {
                            if (dadosCadastraisModel.choosedLanguages
                                    .contains(linguagem) ==
                                false) {
                              setState(() {
                                dadosCadastraisModel.choosedLanguages
                                    .add(linguagem);
                              });
                            } else {
                              setState(() {
                                dadosCadastraisModel.choosedLanguages
                                    .remove(linguagem);
                              });
                            }
                          });
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTitle.buildSubTitle(context,
                      "Pretensão salarial: R\$ ${dadosCadastraisModel.salaryExpectation}"),
                  const SizedBox(
                    height: 10,
                  ),
                  Slider(
                      value: double.parse(
                          dadosCadastraisModel.salaryExpectation.toString()),
                      min: 0,
                      max: 10000,
                      onChanged: (value) {
                        setState(() {
                          dadosCadastraisModel.salaryExpectation =
                              double.parse(value.toStringAsFixed(0));
                        });
                      }),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTitle.buildSubTitle(
                          context, "Tempo de experiência: "),
                      const SizedBox(
                        width: 5,
                      ),
                      DropdownButton(
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                          value: dadosCadastraisModel.experienceTime,
                          items: returnItens(50),
                          onChanged: (value) {
                            setState(() {
                              dadosCadastraisModel.experienceTime =
                                  double.parse(value.toString());
                            });
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                      onPressed: () async {
                        if (_nomeController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: CustomTitle.buildSubTitle(
                                  context, "O nome deve ser preenchido!")));
                        } else {
                          if (_dataNascimentoController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: CustomTitle.buildSubTitle(context,
                                    "A data deve ser preenchida! $dataNascimento")));
                          } else {
                            if (dadosCadastraisModel.levelExperience!
                                .trim()
                                .isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: CustomTitle.buildSubTitle(context,
                                      "O nível de experiência deve ser escolhido!")));
                            } else {
                              if (dadosCadastraisModel
                                  .choosedLanguages.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: CustomTitle.buildSubTitle(
                                            context,
                                            "Escolha pelo menos uma linguagem")));
                              } else {
                                if (dadosCadastraisModel.experienceTime == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content: CustomTitle.buildSubTitle(
                                              context,
                                              "É necessário ter pelo menos 1 ano de experiência")));
                                } else {
                                  if (dadosCadastraisModel.salaryExpectation ==
                                      0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.red,
                                            content: CustomTitle.buildSubTitle(
                                                context,
                                                "A pretensão salarial deve ser maior que 0!")));
                                  } else {
                                    setState(() {
                                      load = true;
                                    });
                                    dadosCadastraisModel.nome =
                                        _nomeController.text;

                                    dadosCadastraisModel.dataNascimento =
                                        _dataNascimentoController.text;
                                    dadosCadastraisRepository
                                        .salvar(dadosCadastraisModel);
                                    setState(() {
                                      load = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.green,
                                            content: CustomTitle.buildSubTitle(
                                                context,
                                                "Cadastro realizado com sucesso!")));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyHomePage()));
                                  }
                                }
                              }
                            }
                          }
                        }
                      },
                      child: CustomTitle.buildTitleButton(context, "Cadastrar"),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
