// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contrast_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContrastModelAdapter extends TypeAdapter<ContrastModel> {
  @override
  final int typeId = 4;

  @override
  ContrastModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContrastModel(
      fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ContrastModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.contrastMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContrastModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
