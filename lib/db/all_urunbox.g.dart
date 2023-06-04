// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_urunbox.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllUrunBoxAdapter extends TypeAdapter<AllUrunBox> {
  @override
  final int typeId = 5;

  @override
  AllUrunBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllUrunBox(
      allUrunler: (fields[0] as List).cast<Urunler>(),
    );
  }

  @override
  void write(BinaryWriter writer, AllUrunBox obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.allUrunler);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllUrunBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
