// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dados_cadastrais_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DadosCadastraisModelAdapter extends TypeAdapter<DadosCadastraisModel> {
  @override
  final int typeId = 0;

  @override
  DadosCadastraisModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DadosCadastraisModel()
      ..nome = fields[0] as String?
      ..dataNascimento = fields[1] as String?
      ..levelExperience = fields[2] as String?
      ..choosedLanguages = (fields[3] as List).cast<String>()
      ..experienceTime = fields[4] as double?
      ..salaryExpectation = fields[5] as double?;
  }

  @override
  void write(BinaryWriter writer, DadosCadastraisModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.dataNascimento)
      ..writeByte(2)
      ..write(obj.levelExperience)
      ..writeByte(3)
      ..write(obj.choosedLanguages)
      ..writeByte(4)
      ..write(obj.experienceTime)
      ..writeByte(5)
      ..write(obj.salaryExpectation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DadosCadastraisModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
