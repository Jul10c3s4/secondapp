import 'package:hive/hive.dart';
import 'package:secondapp/models/cofiguracoes_model.dart';

//Sempre que for necessário usar await para iniciar os valores dos atributos da classe, uma solução é criar um método estático com o atributo estático na classe e late cujo dentro do método possua a atribuição dos atributos usando await e no final deve ser retornado uma construtor vazio criado antes do método.
class ConfiguracoesRepository {
  static late Box _box;
  static const String CHAVE_CONFIG_MODEL = "CHAVE_CONFIG_MODEL";

  ConfiguracoesRepository._create();

  static Future<ConfiguracoesRepository> load() async {
    if (Hive.isBoxOpen("configuracoes")) {
      _box = Hive.box("configuracoes");
    } else {
      _box = await Hive.openBox("configuracoes");
    }

    return ConfiguracoesRepository._create();
  }

  Map saveModel(ConfiguracoesModel configuracoesModel) {
    return <String, String>{
      "userName": configuracoesModel.userName.toString(),
      "height": configuracoesModel.height.toString(),
      "receiverNotifications":
          configuracoesModel.receiverNotifications.toString(),
      "darkTheme": configuracoesModel.darkTheme.toString(),
    };
  }

  void salvar(ConfiguracoesModel configuracoesModel) {
    Map config = saveModel(configuracoesModel);
    _box.put(CHAVE_CONFIG_MODEL, config);
  }

  ConfiguracoesModel getDatas() {
    var configuracoes = _box.get(CHAVE_CONFIG_MODEL);
    if (configuracoes == null) {
      return ConfiguracoesModel.empty();
    } else {
      return ConfiguracoesModel(
          configuracoes["userName"],
          double.parse(configuracoes["height"]),
          bool.parse(configuracoes["receiverNotifications"]),
          bool.parse(configuracoes["darkTheme"]));
    }
  }
}
