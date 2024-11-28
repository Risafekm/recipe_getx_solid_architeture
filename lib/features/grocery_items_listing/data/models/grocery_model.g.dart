// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroceryModelAdapter extends TypeAdapter<GroceryModel> {
  @override
  final int typeId = 2;

  @override
  GroceryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroceryModel(
      id: fields[0] as String,
      name: fields[1] as String,
      isChecked: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, GroceryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroceryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
