import 'package:hive/hive.dart';

part 'tek_siparis.g.dart';

@HiveType(typeId: 3)
class TekSiparis {
  @HiveField(0)
  String id;
  @HiveField(1)
  String siparis;
  @HiveField(2)
  int girilenUrunMiktari;

  TekSiparis({
    required this.id,
    required this.siparis,
    required this.girilenUrunMiktari,
  });
}
