import 'package:hive/hive.dart';
import 'package:secondapp/models/dados_cadastrais_model.dart';

class DadosCadastraisRepository {
  static late Box _box;
  static const String CHAVE_DADOS_CADASTRAIS = "CHAVE_DADOS_CADASTRAIS";
  static const String CHAVE_DADOS_CADASTRAIS_MODEL =
      "CHAVE_DADOS_CADASTRAIS_MODEL";

  DadosCadastraisRepository._create();

  static Future<DadosCadastraisRepository> load() async {
    if (Hive.isBoxOpen(CHAVE_DADOS_CADASTRAIS)) {
      _box = Hive.box(CHAVE_DADOS_CADASTRAIS);
    } else {
      _box = await Hive.openBox(CHAVE_DADOS_CADASTRAIS);
    }

    return DadosCadastraisRepository._create();
  }

  void salvar(DadosCadastraisModel dadosCadastraisModel) {
    _box.put(CHAVE_DADOS_CADASTRAIS_MODEL, dadosCadastraisModel);
  }

  DadosCadastraisModel getDatas() {
    var dadosCadastraisModel = _box.get(CHAVE_DADOS_CADASTRAIS_MODEL);
    if (dadosCadastraisModel == null) {
      print("oi");
      return DadosCadastraisModel.empty();
    } else {
      print("ola");
      return dadosCadastraisModel;
    }
  }
}
