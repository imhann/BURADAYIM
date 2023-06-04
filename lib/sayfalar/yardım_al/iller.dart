import 'package:flutter/material.dart';

import '../../controller/ilcontroller.dart';

class IllerSayfasi extends StatefulWidget {
  const IllerSayfasi({super.key});

  @override
  State<IllerSayfasi> createState() => _IllerSayfasiState();
}

class _IllerSayfasiState extends State<IllerSayfasi> {
  IllerController illerController = IllerController();

  List iller = [
    'Kahramanmaraş',
    'Hatay',
    'Gaziantep',
    'Osmaniye',
    'Malatya',
    'Adana',
    'Diyarbakır',
    'Şanlıurfa',
    'Adıyaman',
    'Kilis',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: iller.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            trailing: Text((index + 1).toString()),
            title: Text(iller[index]),
            onTap: () {
              illerController.secIl(iller[index]);
            },
          ));
        },
      )),
    );
  }
}
