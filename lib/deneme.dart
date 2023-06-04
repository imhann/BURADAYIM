import 'package:buradayim/db/tek_siparis.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'db/sp.dart';

class DenemeSayfasi extends StatefulWidget {
  const DenemeSayfasi({super.key});

  @override
  State<DenemeSayfasi> createState() => _DenemeSayfasiState();
}

class _DenemeSayfasiState extends State<DenemeSayfasi> {
  var boxSiparisler = Hive.box<SiparisModel>('siparisDB');

  List<SiparisModel> tumBilgiler = [];
  List<TekSiparis> veriler = [];

  @override
  void initState() {
    super.initState();
    for (var element in boxSiparisler.values) {
      if ('12121212121' == element.tc) {
        tumBilgiler.add(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: tumBilgiler.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tumBilgiler[index].mapList.length,
              itemBuilder: (context, cc) {
                return Text(tumBilgiler[index].mapList[cc].siparis);
              },
            ),
          );
        },
      ),
    );
  }
  //!
}
