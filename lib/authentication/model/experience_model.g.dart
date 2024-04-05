// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExperienceAdapter extends TypeAdapter<Experience> {
  @override
  final int typeId = 1;

  @override
  Experience read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Experience(
      question: fields[0] as String,
      answer: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Experience obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExperienceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
