// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'urunler.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UrunlerAdapter extends TypeAdapter<Urunler> {
  @override
  final int typeId = 4;

  @override
  Urunler read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Urunler(
      urunAdi: fields[0] as String,
      urunAdet: fields[1] as int,
      girilenUrunMiktari: fields[2] as int,
      urunTedarikDurumu: fields[3] as String,
      yardimAlanmi: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Urunler obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.urunAdi)
      ..writeByte(1)
      ..write(obj.urunAdet)
      ..writeByte(2)
      ..write(obj.girilenUrunMiktari)
      ..writeByte(3)
      ..write(obj.urunTedarikDurumu)
      ..writeByte(4)
      ..write(obj.yardimAlanmi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UrunlerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
