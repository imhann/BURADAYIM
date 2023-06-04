import 'package:hive/hive.dart';

part 'kisi_model.g.dart';

@HiveType(typeId: 1)
class KisiModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String adSoyad;

  @HiveField(2)
  String tel;
  @HiveField(3)
  String sifre;

  @HiveField(4)
  bool yardimAlan;

  // Datetime oluştur
  //gün ile kıyaslama yap 1 geliyorsa bool değeri true yap
  // 0 geliyorsa false yap
  // sisteme girişi ayarla

  @HiveField(5)
  DateTime? gunlukIstem;

  KisiModel({
    required this.id,
    required this.adSoyad,
    required this.tel,
    required this.yardimAlan,
    required this.sifre,
    required this.gunlukIstem,
  });
}
