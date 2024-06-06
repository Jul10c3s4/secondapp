import 'package:secondapp/models/cep_model.dart';
import 'package:http/http.dart' as http;

class ViaCepRepository {
  Future<CepModel> consultarCep(String cep) async {
    var result =
        await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));

    if (result.statusCode == 200) {
      return CepModel.fromJson(result.body);
    }
    return CepModel.empty();
  }
}
