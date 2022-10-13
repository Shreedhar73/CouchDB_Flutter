// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DbDataAdapter extends TypeAdapter<DbData> {
  @override
  final int typeId = 0;

  @override
  DbData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DbData(
      totalRows: fields[0] as int?,
      offset: fields[1] as int?,
      rows: (fields[2] as List?)?.cast<Row>(),
    );
  }

  @override
  void write(BinaryWriter writer, DbData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.totalRows)
      ..writeByte(1)
      ..write(obj.offset)
      ..writeByte(2)
      ..write(obj.rows);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
