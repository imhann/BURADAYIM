import 'package:buradayim/giris_sayfasi.dart';
import 'package:buradayim/sabitler/renk.dart';
import 'package:buradayim/sayfalar/admin/kisidetay.dart';
import 'package:buradayim/sayfalar/admin/otomatik_eslesme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../db/kisi_model.dart';

class NewAdminSayfasi extends StatefulWidget {
  const NewAdminSayfasi({super.key});

  @override
  State<NewAdminSayfasi> createState() => _NewAdminSayfasiState();
}

class _NewAdminSayfasiState extends State<NewAdminSayfasi> {
  //Veri tabamı
  var boxKisiDB = Hive.box<KisiModel>('kisiDB');
  List<KisiModel> yardimAlanlar = [];
  List<KisiModel> yardimEdenler = [];

  //alt menu
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    for (var element in boxKisiDB.values) {
      if (element.yardimAlan == true) {
        yardimAlanlar.add(element);
      } else {
        yardimEdenler.add(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gelenRenk(_selectedIndex),
      appBar: appbar(),
      body: SafeArea(
          child: _selectedIndex == 0
              ? ListView.builder(
                  itemCount: yardimAlanlar.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Get.to(KisiDetay(kisiModel: yardimAlanlar[index]));
                        },
                        title: Text(yardimAlanlar[index].adSoyad),
                        subtitle: Text(yardimAlanlar[index].id.toString()),
                      ),
                    );
                  },
                )
              : ListView.builder(
                  itemCount: yardimEdenler.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Get.to(KisiDetay(kisiModel: yardimEdenler[index]));
                        },
                        title: Text(yardimEdenler[index].adSoyad),
                        subtitle: Text(yardimEdenler[index].id.toString()),
                      ),
                    );
                  },
                )),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 18,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        elevation: 0,
        type: BottomNavigationBarType.fixed, // Fixed
        backgroundColor: SbtRenkler.beyaz, // <-- This works for fixed
        selectedItemColor: SbtRenkler.mavi,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.call,
              size: 20,
            ),
            label: 'Depremzedeler',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 20,
            ),
            label: 'Bağış Yapanlar',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        mini: true,
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const GirisSayfasi(),
              ),
              (route) => false);
        },
        child: const Icon(Icons.home),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        TextButton(
          child: const Text('Otomatik Eşleşme'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const OtomatikEslesmeSayfasi(),
            ));
          },
        ),
      ],
      title: const Text(
        'Admin: İmhan ACAR ',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color gelenRenk(int i) {
    if (i == 0) {
      return Colors.green;
    } else {
      return SbtRenkler.mavi;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
