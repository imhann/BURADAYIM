import 'package:buradayim/db/urunler.dart';
import 'package:buradayim/sabitler/renk.dart';
import 'package:buradayim/sayfalar/yard%C4%B1m_al/giris.dart';
import 'package:buradayim/sayfalar/yard%C4%B1m_al/listem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../db/kisi_model.dart';

// ignore: must_be_immutable
class ListelemeAl extends StatefulWidget {
  List gelenListem;
  String baslik;
  KisiModel kisiModel;
  List<Urunler> listUrunler;

  ListelemeAl({
    super.key,
    required this.gelenListem,
    required this.kisiModel,
    required this.baslik,
    required this.listUrunler,
  });

  @override
  State<ListelemeAl> createState() => _ListelemeAlState();
}

class _ListelemeAlState extends State<ListelemeAl> {
  List<dynamic> liste = [];
  var boxUrunler = Hive.box<Urunler>('urunDB');
  var boxUrunlerGecici = Hive.box<Urunler>('urunDBX');

//Geçici liste sürekli
  List<Urunler> listeUrun = [];
  List<Urunler> listeUrunOlustur = [];

  var boxGecici = Hive.box('geciciDB');

  int gecici = 0;

  @override
  void initState() {
    super.initState();
    //listeUrun = widget.listUrunler;

    liste = widget.gelenListem;
    //Gelen listeyi sayfa açılmadan önce listemize çekiyoruz
    for (var element in widget.gelenListem) {
      for (var ff in widget.listUrunler) {
        if (ff.urunAdi == element) {
          listeUrun.add(ff);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.exit_to_app,
                  color: SbtRenkler.mavi,
                )),
          ],
          automaticallyImplyLeading: false,
          title: Text(
            widget.baslik,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        body: ListView.builder(
          itemCount: liste.length,
          itemBuilder: (context, index) {
            var adet = 0;
            for (var element in listeUrun) {
              if (element.urunAdi == liste[index]) {
                adet = element.girilenUrunMiktari;
              }
            }

            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(liste[index])),
                  const Expanded(child: SizedBox()),
                  Expanded(
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                for (var element in listeUrun) {
                                  if (element.urunAdi == liste[index]) {
                                    if (adet > 0) {
                                      element.girilenUrunMiktari =
                                          element.girilenUrunMiktari - 1;
                                    }
                                  }
                                }
                              });
                            },
                            icon: const Icon(Icons.remove)),
                        Text(adet.toString()),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                for (var element in listeUrun) {
                                  if (element.urunAdi == liste[index]) {
                                    element.girilenUrunMiktari =
                                        element.girilenUrunMiktari + 1;
                                  }
                                }
                              });
                            },
                            icon: const Icon(Icons.add)),
                      ]),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        floatingActionButton: Consumer<ListProvider>(
          builder: (context, prv, child) {
            return FloatingActionButton(
              mini: true,
              backgroundColor: SbtRenkler.mavi,
              child: const Icon(Icons.check),
              onPressed: () async {
                final now = DateTime.now();
                for (var element in listeUrun) {
                  if (element.girilenUrunMiktari != 0) {
                    prv.addItem(element);
                    listeUrunOlustur.add(element);
                    for (var i = 0; i < element.girilenUrunMiktari; i++) {
                      await boxUrunlerGecici.add(element);
                    }
                  }
                }
                Get.to(YrdAlGirisSayfasi(
                  kisiModel: widget.kisiModel,
                  siparisYapildimi: now,
                  listeUrun: listeUrunOlustur,
                ));
              },
            );
          },
        ));
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Uyarı"),
      content: const Text("Ürün şuan elimizde malesef yok."),
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
