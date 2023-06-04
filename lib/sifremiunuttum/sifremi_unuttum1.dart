import 'package:buradayim/db/kisi_model.dart';
import 'package:buradayim/giris_sayfasi.dart';
import 'package:buradayim/sabitler/textfild.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';

class SifremiUnuttum extends StatefulWidget {
  const SifremiUnuttum({super.key});

  @override
  State<SifremiUnuttum> createState() => _SifremiUnuttumState();
}

class _SifremiUnuttumState extends State<SifremiUnuttum> {
  var tcController = TextEditingController();
  var sifreController = TextEditingController();
  bool yardimAlan = true;
  bool yardimAl = true;
  bool yardimVer = false;

  List<KisiModel> allKisiler = [];

  var boxKisiler = Hive.box<KisiModel>('kisiDB');

  @override
  void initState() {
    super.initState();
    for (var element in boxKisiler.values) {
      allKisiler.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SbtTextfild(hintText: 'TC', textEditingController: tcController),
          SbtTextfildSifre(
              hintText: 'Yeni şifre', textEditingController: sifreController),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Yardım Almak İsteyen'),
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
          ElevatedButton(
            child: const Text('Devam Et'),
            onPressed: () async {
              for (var element in allKisiler) {
                if (tcController.text == element.id) {
                  var guncelenenKisi = KisiModel(
                    id: element.id,
                    adSoyad: element.adSoyad,
                    tel: element.tel,
                    yardimAlan: yardimAlan,
                    sifre: sifreController.text,
                    gunlukIstem: element.gunlukIstem,
                  );
                  await boxKisiler.put(tcController.text, guncelenenKisi);
                  Get.snackbar('', 'Şifreniz Güncellendi');
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const GirisSayfasi(),
                      ),
                      (route) => false);
                }
              }
            },
          )
        ],
      ),
    )));
  }
}
