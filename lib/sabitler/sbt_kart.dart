import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SbtKart extends StatelessWidget {
  dynamic resimYolu;
  String baslik;
  Function() onTop;
  SbtKart(
      {super.key,
      required this.resimYolu,
      required this.baslik,
      required this.onTop});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTop,
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(resimYolu),
          const SizedBox(height: 10),
          Text(baslik)
        ],
      )),
    );
  }
}
