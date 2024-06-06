class TarefasBack4AppModel {
  //Nesse caso como a relação entre as classes são simples é melhor alterar aqui para não der erro dos valores ser nulos, sendo melhor reiniciar as variáveis
  List<TarefaBack4AppModel> taferas = [];

  TarefasBack4AppModel(this.taferas);

  TarefasBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      taferas = <TarefaBack4AppModel>[];
      json['results'].forEach((v) {
        taferas.add(TarefaBack4AppModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = taferas.map((v) => v.toJson()).toList();
    return data;
  }
}

class TarefaBack4AppModel {
  String objectId = "";
  String descricao = "";
  bool concluido = false;
  String createdAt = "";
  String updatedAt = "";

  TarefaBack4AppModel(this.objectId, this.descricao, this.concluido,
      this.createdAt, this.updatedAt);

  TarefaBack4AppModel.create(this.descricao, this.concluido);

  TarefaBack4AppModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    descricao = json['descricao'];
    concluido = json['concluido'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    return data;
  }
}
