import 'package:buradayim/sayfalar/admin/islem_animation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../db/sp.dart';
import '../../db/tek_siparis.dart';
import '../../db/urunler.dart';

class OtomatikEslesmeSayfasi extends StatefulWidget {
  const OtomatikEslesmeSayfasi({super.key});

  @override
  State<OtomatikEslesmeSayfasi> createState() => _OtomatikEslesmeSayfasiState();
}

class _OtomatikEslesmeSayfasiState extends State<OtomatikEslesmeSayfasi> {
  var boxSiparisler = Hive.box<SiparisModel>('siparisDB');
  var boxAllSiparisler = Hive.box<Urunler>('urunDB');

  List<SiparisModel> tumSpraisler = []; // ihtiyaç talepleri
  List<TekSiparis> herSiparisinSiparisleri = [];

  List<Urunler> allSparisler = [];

  //
  @override
  void initState() {
    super.initState();

    for (var element in boxAllSiparisler.values) {
      allSparisler.add(element);
    }
    for (var element in boxSiparisler.values) {
      if (element.yardimAl == true) {
        tumSpraisler.add(element);
      }
    }
    for (var element in tumSpraisler) {
      for (var ff in element.mapList) {
        herSiparisinSiparisleri.add(ff);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Otomatik Eşleşme'),
          actions: [
            IconButton(
                onPressed: () {
                  urunMiktariniAyarlama();

                  setState(() {});
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const IslemAnimatedSayfasi(),
                  ));
                },
                icon: const Icon(
                  Icons.play_circle,
                  color: Colors.indigo,
                ))
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  'Gelen Bağışlar',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Talep Edilen İhtiyaçlar',
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allSparisler.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              allSparisler[index].urunAdi,
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 12),
                            ),
                            trailing: Text(
                                allSparisler[index].urunAdet.toString(),
                                style: const TextStyle(color: Colors.green)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              allSparisler[index].urunAdi,
                              style: const TextStyle(
                                  color: Colors.orange, fontSize: 14),
                            ),
                            leading: Text(
                                allSparisler[index]
                                    .girilenUrunMiktari
                                    .toString(),
                                style: const TextStyle(color: Colors.orange)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Future<void> urunMiktariniAyarlama() async {
    for (var i = 0; i < tumSpraisler.length; i++) {
      var siparisModel = tumSpraisler[i];
      if (siparisModel.yardimAl == true) {

        // kişisinin 1.sparişinin içindeki istek listesi

        for (var k = 0; k < siparisModel.mapList.length; k++) {

          //Ürünlerin stoktaki durumunu kontrol ettiğim db de gez

          for (var f = 0; f < allSparisler.length; f++) {

            // 1.sp istek listesindeki  k'cı isteği ile tüm listemin içindeki ürünün adı birbirine eşleşiyorsa gir

            if (siparisModel.mapList[k].siparis == allSparisler[f].urunAdi) {

              if (allSparisler[f].urunAdet -
                      siparisModel.mapList[k].girilenUrunMiktari >
                  0) {
                var siparis = allSparisler[f];
                var guncelUrun = Urunler(
                    yardimAlanmi: true,
                    urunAdi: siparis.urunAdi,
                    urunAdet: siparis.urunAdet -
                        siparisModel.mapList[k].girilenUrunMiktari,
                    girilenUrunMiktari: 0,
                    urunTedarikDurumu: "Urun PTT'de");
                allSparisler[f] = guncelUrun;
                await boxAllSiparisler.put(allSparisler[f].urunAdi, guncelUrun);

                //
                var siparisUpdate = SiparisModel(
                  siparisID: siparisModel.siparisID,
                  tc: siparisModel.tc,
                  dateTime: siparisModel.dateTime,
                  sehir: siparisModel.sehir,
                  enlemLat: siparisModel.enlemLat,
                  boylamLan: siparisModel.boylamLan,
                  mapList: [],
                  yardimAl: siparisModel.yardimAl,
                  tedarikDurumu: "Urun PTT'de",
                );

                await boxSiparisler.put(siparisModel.siparisID, siparisUpdate);
                setState(() {});
              }
            } else {}
          }
        }
      }
    }
  }

//
}
