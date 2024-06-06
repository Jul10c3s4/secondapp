import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:secondapp/models/tarefas_back4app_model.dart';
import 'package:secondapp/repositories/back4app/tarefas_back4app_custom_dio.dart';

class TarefasBack4AppRepository {
  final _customDio = Back4AppCustomDio();

  TarefasBack4AppRepository();

  Future<TarefasBack4AppModel> getTarefas() async {
    var result = await _customDio.dio.get('');
    if (result.statusCode == 200) {
      return TarefasBack4AppModel.fromJson(result.data);
    }
    return TarefasBack4AppModel(<TarefaBack4AppModel>[]);
  }

  Future<TarefasBack4AppModel> getTarefasCompleOrUncople(bool completas) async {
    var result = await _customDio.dio
        .get("?where={\"concluido\":${completas.toString()}}");
    if (result.statusCode == 200) {
      return TarefasBack4AppModel.fromJson(result.data);
    }
    return TarefasBack4AppModel(<TarefaBack4AppModel>[]);
  }

  void completeTask(String id, bool state) async {
    await _customDio.dio.put("/$id", data: {"concluido": state});
  }

  void updateTask(String id, String descricao) async {
    await _customDio.dio.put("/$id", data: {"descricao": descricao});
  }

  Future<List<TarefaBack4AppModel>> createTask(
      TarefaBack4AppModel tarefaBack4AppModel) async {
    await _customDio.dio.post("", data: tarefaBack4AppModel.toCreateJson());
    var tasks = await getTarefas();
    return tasks.taferas;
  }

  void deleteTask(String id) async {
    await _customDio.dio.delete("/$id");
  }
}
