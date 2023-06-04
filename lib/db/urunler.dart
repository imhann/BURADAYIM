import 'package:hive/hive.dart';
part 'urunler.g.dart';

@HiveType(typeId: 4)
class Urunler {
  @HiveField(0)
  String urunAdi;
  @HiveField(1)
  int urunAdet;

  @HiveField(2)
  int girilenUrunMiktari;

  @HiveField(3)
  String urunTedarikDurumu;

  @HiveField(4)
  bool yardimAlanmi;

  Urunler({
    required this.urunAdi,
    required this.urunAdet,
    required this.girilenUrunMiktari,
    this.urunTedarikDurumu = 'Bekleniyor',
    required this.yardimAlanmi,
  });
}
