// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymns_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HymnAdapter extends TypeAdapter<Hymn> {
  @override
  final int typeId = 0;

  @override
  Hymn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hymn(
      id: fields[0] as int?,
      hymnNo: fields[1] as String?,
      category: fields[2] as int?,
      title: fields[3] as String?,
      bibleText: fields[4] as String?,
      english: fields[5] as String?,
      yorubaTitle: fields[6] as String?,
      yorubaBibleText: fields[7] as String?,
      yoruba: fields[8] as String?,
      strectitle: fields[9] as String?,
      stryctitle: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Hymn obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.hymnNo)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.bibleText)
      ..writeByte(5)
      ..write(obj.english)
      ..writeByte(6)
      ..write(obj.yorubaTitle)
      ..writeByte(7)
      ..write(obj.yorubaBibleText)
      ..writeByte(8)
      ..write(obj.yoruba)
      ..writeByte(9)
      ..write(obj.strectitle)
      ..writeByte(10)
      ..write(obj.stryctitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HymnAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
