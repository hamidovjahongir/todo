// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_mode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoModeAdapter extends TypeAdapter<TodoMode> {
  @override
  final int typeId = 0;

  @override
  TodoMode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoMode(
      id: fields[0] as int,
      name: fields[1] as String,
      degree: fields[2] as int,
      isDone: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, TodoMode obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.degree)
      ..writeByte(3)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
