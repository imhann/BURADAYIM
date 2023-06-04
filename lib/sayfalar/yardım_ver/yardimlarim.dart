import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../db/kisi_model.dart';
import '../../db/sp.dart';
import '../../db/tek_siparis.dart';
import '../../sabitler/renk.dart';
import '../../sabitler/resimyolu.dart';

// ignore: must_be_immutable
class YardimlarimSayfasi extends StatefulWidget {
  KisiModel kisiModel;
  YardimlarimSayfasi({super.key, required this.kisiModel});

  @override
  State<YardimlarimSayfasi> createState() => _YardimlarimSayfasiState();
}

class _YardimlarimSayfasiState extends State<YardimlarimSayfasi> {
  //Veri tabanıo
  var boxSiparisler = Hive.box<SiparisModel>('siparisDB');
  var boxListDB = Hive.box('listDB');

  List<SiparisModel> tumBilgiler = [];
  List<TekSiparis> veriler = [];

  @override
  void initState() {
    super.initState();
    for (var element in boxSiparisler.values) {
      if (widget.kisiModel.id == element.tc) {
        tumBilgiler.add(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yardımlarım'),
      ),
      body: ListView.builder(
        itemCount: tumBilgiler.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                image: DecorationImage(
                    image: AssetImage(
                      ImageConstants.instance.nt2,
                    ),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        solTaraf(index),
                        // Burada kıyaslama yapıyoruz
                        // Eğer kişinin bir siparişi veya bağışı varsa bir liste getirmesini
                        // yoksa boş bir konteiner getirmesini söylüyoruz
                        // Böylelikle programın çökmesini engellemiş oluyorz

                        tumBilgiler[index].mapList.isNotEmpty
                            ? sagTaraf(index)
                            : Container(
                                color: Colors.red,
                              )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded sagTaraf(int index) {
    return Expanded(
      flex: 3,
      child: SizedBox(
        width: Get.size.width,
        height: Get.size.width / 2,
        child: Center(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: tumBilgiler[index].mapList.length,
          itemBuilder: (context, cc) {
            return Text(
              tumBilgiler[index].mapList[cc].siparis,
              style: const TextStyle(fontSize: 14),
            );
          },
        )),
      ),
    );
  }

  Expanded solTaraf(int index) {
    return Expanded(
      flex: 2,
      child: Center(
          child: Column(
        children: [
          //liste numarasını çekme
          CircleAvatar(
            backgroundColor: SbtRenkler.beyaz,
            child: Text((index + 1).toString(),
                style: const TextStyle(fontSize: 24, color: SbtRenkler.mavi)),
          ),
          //Boşluk
          const SizedBox(height: 28),
          // veri tabanından taqrih çekip anlaşılır formatla yazdırma
          Text(tarihDegistirme(tumBilgiler[index].dateTime!),
              style: const TextStyle(fontSize: 10)),
          //Boşluk
          const SizedBox(height: 8),
          //v.tabanından şehri seçme
          Text(tumBilgiler[index].sehir,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          // Enlem ve boylam seçme
          Text('Enlem :${tumBilgiler[index].enlemLat}',
              style: const TextStyle(fontSize: 10)),
          Text('Boylam :${tumBilgiler[index].boylamLan}',
              style: const TextStyle(fontSize: 10)),
          Text(tumBilgiler[index].tedarikDurumu,
              style: const TextStyle(fontSize: 10, color: Colors.red)),
        ],
      )),
    );
  }

  AppBar appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        widget.kisiModel.adSoyad,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  tarihDegistirme(DateTime date) {
    var tarih = DateFormat.yMMMd('tr').format(date).toString();
    return tarih;
  }
}
