import 'package:hive/hive.dart';

part 'dados_cadastrais_model.g.dart';

@HiveType(typeId: 0)
class DadosCadastraisModel extends HiveObject {
  @HiveField(0)
  String? nome;

  @HiveField(1)
  String? dataNascimento;

  @HiveField(2)
  String? levelExperience;

  @HiveField(3)
  List<String> choosedLanguages = [];

  @HiveField(4)
  double? experienceTime;

  @HiveField(5)
  double? salaryExpectation;

  DadosCadastraisModel();

  DadosCadastraisModel.empty() {
    nome = "";
    dataNascimento = "";
    levelExperience = "";
    choosedLanguages = [];
    experienceTime = 0;
    salaryExpectation = 0;
  }
}
