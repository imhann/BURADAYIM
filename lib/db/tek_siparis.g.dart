// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tek_siparis.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TekSiparisAdapter extends TypeAdapter<TekSiparis> {
  @override
  final int typeId = 3;

  @override
  TekSiparis read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TekSiparis(
      id: fields[0] as String,
      siparis: fields[1] as String,
      girilenUrunMiktari: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TekSiparis obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.siparis)
      ..writeByte(2)
      ..write(obj.girilenUrunMiktari);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TekSiparisAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
