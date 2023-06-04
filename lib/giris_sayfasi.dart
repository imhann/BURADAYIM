import 'package:buradayim/db/kisi_model.dart';
import 'package:buradayim/deneme.dart';
import 'package:buradayim/sabitler/renk.dart';
import 'package:buradayim/sabitler/resimyolu.dart';
import 'package:buradayim/sabitler/textfild.dart';
import 'package:buradayim/sayfalar/admin/admin_sayfasi.dart';
import 'package:buradayim/sayfalar/kaydolma.dart';
import 'package:buradayim/sayfalar/yard%C4%B1m_al/giris.dart';
import 'package:buradayim/sayfalar/yard%C4%B1m_ver/deneme.dart';
import 'package:buradayim/sifremiunuttum/sifremi_unuttum1.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({super.key});

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
// Controller
  var tcController = TextEditingController();
  var sifreController = TextEditingController();
  var boxKisiDB = Hive.box<KisiModel>('kisiDB');
  bool hataMesaji = false;

  //Soldan açılan çekmece Draver manu
  var drawerHeader = const UserAccountsDrawerHeader(
      accountName: Text('Ad Soyad'), accountEmail: Text('mail'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: SbtRenkler.truncu,
          iconTheme: const IconThemeData(color: Colors.white)),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: Get.size.width,
          height: Get.size.height,
          decoration: BoxDecoration(
            color: SbtRenkler.beyaz,
            image: DecorationImage(
              image: AssetImage(ImageConstants.instance.arkaPlan),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // En üsteki başlık
              buradayiz(),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SbtTextfild(
                            hintText: 'TC',
                            textEditingController: tcController),
                        SbtTextfildSifre(
                            hintText: 'Sifre',
                            textEditingController: sifreController),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Get.to(const SifremiUnuttum());
                                },
                                child: const Text('Şifremi Unuttum'))
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (tcController.text == '11' &&
                                  sifreController.text == 'aa') {
                                Get.to(const NewAdminSayfasi());
                              } else {
                                var gelen = await girisKontrol();
                                if (gelen == true) {
                                  Get.snackbar('Uyarı',
                                      "Tc ve Şifreni kontrol ettikden sonra tekrar dene. Şifreni unuttuysan Şifremi unuttum kısmından şifreni güncelleyebilirsin. Geçmiş olsun... ",
                                      backgroundColor: Colors.orange,
                                      icon: const Icon(Icons.error));
                                }
                              }
                            },
                            child: const Text('Giriş Yap')),
                        // Kaydolma ekranına gitme

                        TextButton(
                            onPressed: () {
                              Get.to(const KaydolmaEkrani());
                            },
                            child: const Text(
                              'Kaydolmak için buraya tıklayabilirisin.',
                              style: TextStyle(color: Colors.orange),
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool girisKontrol() {
    for (var element in boxKisiDB.values) {
      if (tcController.text == element.id &&
          sifreController.text == element.sifre &&
          element.yardimAlan == true) {
        hataMesaji = false;
        Get.to(YrdAlGirisSayfasi(
          kisiModel: element,
          siparisYapildimi: null,
          listeUrun: const [],
        ));
        hataMesaji = false;
        break;
      } else if (tcController.text == element.id &&
          sifreController.text == element.sifre &&
          element.yardimAlan == false) {
        hataMesaji = false;

        Get.to(YardimVerDeneme(
          kisiModel: element,
          siparisYapildimi: null,
          listeUrun: const [],
        ));
        hataMesaji = false;
        break;
      } else {
        hataMesaji = true;
      }
    }
    return hataMesaji;
  }

  SizedBox buradayiz() {
    return SizedBox(
      width: Get.size.width,
      height: Get.size.height / 4,
      child: Center(
        child: InkWell(
          onTap: () {
            Get.to(const DenemeSayfasi());
          },
          child: Text(
            'BURADAYIM',
            style: GoogleFonts.kumarOne(
              textStyle: const TextStyle(color: SbtRenkler.beyaz, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
