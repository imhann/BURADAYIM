import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../db/kisi_model.dart';
import '../../db/sp.dart';
import '../../db/tek_siparis.dart';
import '../../db/urunler.dart';

// ignore: must_be_immutable
class YardimOnaySayfasi extends StatefulWidget {
  KisiModel kisiModel;
  SiparisModel istenenUrunler;
  String siparisID;

  YardimOnaySayfasi({
    super.key,
    required this.kisiModel,
    required this.istenenUrunler,
    required this.siparisID,
  });

  @override
  State<YardimOnaySayfasi> createState() => _YardimOnaySayfasiState();
}

class _YardimOnaySayfasiState extends State<YardimOnaySayfasi> {
  SiparisModel? sipars;

  var boxUrunler = Hive.box<Urunler>('urunDB');
  var boxSiparisler = Hive.box<SiparisModel>('siparisDB');

  List<Urunler> allUrunler = [];
  List<TekSiparis> tekSparis = [];

  late SiparisModel siparisModel;

  @override
  void initState() {
    super.initState();
    for (var element in boxSiparisler.values) {
      if (widget.siparisID == element.siparisID) {
        siparisModel = element;
      }
    }
    sipars = widget.istenenUrunler;
    tekSparis = sipars!.mapList;
    tumUrunleriGetir();
  }

  void tumUrunleriGetir() {
    for (var element in boxUrunler.values) {
      allUrunler.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yardım Onay Sayfası'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: tekSparis.length,
        itemBuilder: (context, cc) {
          for (var element in allUrunler) {
            // ignore: unrelated_type_equality_checks
            if (sipars!.mapList[cc].siparis == element.urunAdi) {
              return Card(
                child: ListTile(
                  onTap: () {
                    setState(() {});
                    urunMiktariniAyarlama(sipars!.mapList[cc].siparis, cc);
                  },
                  title: Text(
                    sipars!.mapList[cc].siparis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: Text(
                    element.urunAdet.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }

  Future<void> urunMiktariniAyarlama(String urunAdi, int cc) async {
    for (var i = 0; i < allUrunler.length; i++) {
      // ignore: unrelated_type_equality_checks
      if (allUrunler[i].urunAdi == urunAdi) {
        if (allUrunler[i].urunAdet > 0) {
          var guncelle = Urunler(
            yardimAlanmi: true,
            urunAdi: allUrunler[i].urunAdi,
            urunAdet: allUrunler[i].urunAdet - 1,
            girilenUrunMiktari: 0,
            urunTedarikDurumu: "Urun PTT'de",
          );
          allUrunler[i] = guncelle;
          await boxUrunler.put(allUrunler[i].urunAdi, guncelle);
          tekSparis.removeAt(cc);

          // sipariş durum güncellemesi
          var siparisUpdate = SiparisModel(
            siparisID: siparisModel.siparisID,
            tc: siparisModel.tc,
            dateTime: siparisModel.dateTime,
            sehir: siparisModel.sehir,
            enlemLat: siparisModel.enlemLat,
            boylamLan: siparisModel.boylamLan,
            mapList: siparisModel.mapList,
            yardimAl: siparisModel.yardimAl,
            tedarikDurumu: "Urun PTT'de",
          );
          await boxSiparisler.put(siparisModel.siparisID, siparisUpdate);
          setState(() {});
        } else {
          showAlertDialog(context);
        }
      }
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Uyarı"),
      content: const Text("Elinizde bu ürün tükenmiş gözüküyor"),
      actions: [
        ElevatedButton(
          child: const Text('İptal'),
          onPressed: () {
            Get.back();
          },
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
