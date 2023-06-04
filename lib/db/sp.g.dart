// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiparisModelAdapter extends TypeAdapter<SiparisModel> {
  @override
  final int typeId = 2;

  @override
  SiparisModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SiparisModel(
      siparisID: fields[0] as String,
      tc: fields[1] as String,
      dateTime: fields[2] as DateTime?,
      sehir: fields[3] as String,
      enlemLat: fields[4] as String,
      boylamLan: fields[5] as String,
      mapList: (fields[6] as List).cast<TekSiparis>(),
      yardimAl: fields[7] as bool,
      tedarikDurumu: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SiparisModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.siparisID)
      ..writeByte(1)
      ..write(obj.tc)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.sehir)
      ..writeByte(4)
      ..write(obj.enlemLat)
      ..writeByte(5)
      ..write(obj.boylamLan)
      ..writeByte(6)
      ..write(obj.mapList)
      ..writeByte(7)
      ..write(obj.yardimAl)
      ..writeByte(8)
      ..write(obj.tedarikDurumu);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SiparisModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
