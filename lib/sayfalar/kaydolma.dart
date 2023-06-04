import 'package:buradayim/db/kisi_model.dart';
import 'package:buradayim/giris_sayfasi.dart';
import 'package:buradayim/sabitler/renk.dart';
import 'package:buradayim/sabitler/textfild.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';

class KaydolmaEkrani extends StatefulWidget {
  const KaydolmaEkrani({super.key});

  @override
  State<KaydolmaEkrani> createState() => _KaydolmaEkraniState();
}

class _KaydolmaEkraniState extends State<KaydolmaEkrani> {
  var tcController = TextEditingController();
  var adSotadController = TextEditingController();
  var sifreController = TextEditingController();
  var telController = TextEditingController();
  bool yardimAlan = true;

  bool yardimAl = true;
  bool yardimVer = false;

  //Veri tabanını çağır
  var boxkisiDB = Hive.box<KisiModel>('kisiDB');
  List<KisiModel> tumKisiler = [];
  bool kisiVerYok = false;

  @override
  void initState() {
    for (var element in boxkisiDB.values) {
      tumKisiler.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SbtRenkler.beyaz,
      body: ListView(children: [
        const SizedBox(height: 20),
        SbtTextfild2(
            hintText: 'Ad Soyad', textEditingController: adSotadController),
        SbtTextfild(hintText: 'Telefon', textEditingController: telController),
        SbtTextfild(hintText: 'TC', textEditingController: tcController),
        SbtTextfildSifre(hintText: 'Şifre', textEditingController: sifreController),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('Yardım Almak İstiyorum'),
            Checkbox(
              value: yardimAl,
              onChanged: (value) {
                setState(() {
                  yardimAl = !yardimAl;
                  yardimVer = false;
                  yardimAlan = true;
                });
              },
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('Bağış Yapacağım'),
            Checkbox(
              value: yardimVer,
              onChanged: (value) {
                setState(() {
                  yardimAlan = false;

                  yardimVer = !yardimVer;
                  yardimAl = false;
                });
              },
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(150, 50)),
              onPressed: () {
                for (var element in tumKisiler) {
                  if (tcController.text == element.id) {
                    kisiVerYok = true;
                  }
                }
                kisiKaydet();
              },
              child: const Text('Kaydol'),
            ),
          ],
        )
      ]),
    );
  }

  Future<void> kisiKaydet() async {
    setState(() {});

    if (kisiVerYok == false) {
      if (adSotadController.text.isNotEmpty ||
          telController.text.isNotEmpty ||
          tcController.text.isNotEmpty ||
          sifreController.text.isNotEmpty) {
        if (telController.text.length == 11 && tcController.text.length == 11) {
          var eklenecekKisi = KisiModel(
            id: tcController.text,
            adSoyad: adSotadController.text,
            tel: telController.text,
            yardimAlan: yardimAlan,
            sifre: sifreController.text,
            gunlukIstem: null,
          );
          Get.snackbar('', 'Sisteme Kaydedildiniz',
              backgroundColor: Colors.greenAccent);
          Get.to(const GirisSayfasi());
          await boxkisiDB.put(tcController.text, eklenecekKisi);
          alanlariTemizleme();
        } else {
          Get.snackbar('Uyarı', 'Tc ve Telefon Numarası 11 karakter olmalı');
        }
      } else {
        Get.snackbar('Uyarı', 'Tüm alanları doldurduktan sonra tekrar dene');
      }
    } else {
      Get.snackbar('Uyarı',
          'Bir Tc Kimlik numarası ile sadece bir kere kaydolabilirsiniz.',
          backgroundColor: Colors.orange);
    }
  }

  alanlariTemizleme() {
    adSotadController.clear();
    telController.clear();
    tcController.clear();
    sifreController.clear();
  }
}
