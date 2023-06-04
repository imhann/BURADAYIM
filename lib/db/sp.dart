import 'package:buradayim/db/tek_siparis.dart';
import 'package:hive/hive.dart';

part 'sp.g.dart';

@HiveType(typeId: 2)
class SiparisModel {
  @HiveField(0)
  String siparisID;
  @HiveField(1)
  String tc;
  @HiveField(2)
  DateTime? dateTime;
  @HiveField(3)
  String sehir;
  @HiveField(4)
  String enlemLat;
  @HiveField(5)
  String boylamLan;
  @HiveField(6)
  List<TekSiparis> mapList;
  @HiveField(7)
  bool yardimAl;
  @HiveField(8)
  String tedarikDurumu;

  SiparisModel({
    required this.siparisID,
    required this.tc,
    required this.dateTime,
    required this.sehir,
    required this.enlemLat,
    required this.boylamLan,
    required this.mapList,
    required this.yardimAl,
    this.tedarikDurumu = 'Bekleniyor',
  });
}
