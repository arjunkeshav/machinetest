// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'font_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FontModelAdapter extends TypeAdapter<FontModel> {
  @override
  final int typeId = 1;

  @override
  FontModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FontModel(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FontModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.selectedFont);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FontModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
