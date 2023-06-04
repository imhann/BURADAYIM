import 'package:buradayim/db/all_urunbox.dart';
import 'package:buradayim/db/kisi_model.dart';
import 'package:buradayim/db/tek_siparis.dart';
import 'package:buradayim/db/urunler.dart';
import 'package:buradayim/giris_sayfasi.dart';
import 'package:buradayim/sabitler/renk.dart';
import 'package:buradayim/sabitler/yazi_tema.dart';
import 'package:buradayim/sayfalar/yard%C4%B1m_al/listem.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'db/sp.dart';

Future<void> main() async {
  await Hive.initFlutter();
  //Veri tabanı adaptörü
  Hive.registerAdapter(KisiModelAdapter());
  Hive.registerAdapter(SiparisModelAdapter());
  Hive.registerAdapter(TekSiparisAdapter());
  Hive.registerAdapter(AllUrunBoxAdapter());
  Hive.registerAdapter(UrunlerAdapter());

  //Veri Tabanı
  await Hive.openBox<KisiModel>('kisiDB');
  await Hive.openBox<SiparisModel>('siparisDB');
  await Hive.openBox<SiparisModel>('siparisDByardimVer');
  await Hive.openBox<AllUrunBox>('allUrunDB');
  await Hive.openBox<Urunler>('urunDB');
  await Hive.openBox<Urunler>('urunDBX');

  await Hive.openBox('geciciDB');
  await Hive.openBox('listDB');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListProvider(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: SbtRenkler.beyaz,
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(color: SbtRenkler.mavi),
                elevation: 0,
                backgroundColor: SbtRenkler.beyaz),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: SbtRenkler.mavi,
              ),
            ),
            textTheme: textTheme),
        title: 'Material App',
        home: const GirisSayfasi(),
      ),
    );
  }
}
