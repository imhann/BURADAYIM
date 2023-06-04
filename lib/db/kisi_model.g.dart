// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kisi_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KisiModelAdapter extends TypeAdapter<KisiModel> {
  @override
  final int typeId = 1;

  @override
  KisiModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KisiModel(
      id: fields[0] as String,
      adSoyad: fields[1] as String,
      tel: fields[2] as String,
      yardimAlan: fields[4] as bool,
      sifre: fields[3] as String,
      gunlukIstem: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, KisiModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.adSoyad)
      ..writeByte(2)
      ..write(obj.tel)
      ..writeByte(3)
      ..write(obj.sifre)
      ..writeByte(4)
      ..write(obj.yardimAlan)
      ..writeByte(5)
      ..write(obj.gunlukIstem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KisiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
