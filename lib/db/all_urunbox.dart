import 'package:buradayim/db/urunler.dart';
import 'package:hive/hive.dart';
part 'all_urunbox.g.dart';

@HiveType(typeId: 5)
class AllUrunBox {
  @HiveField(0)
  List<Urunler> allUrunler;

  AllUrunBox({
    required this.allUrunler,
  });
}
