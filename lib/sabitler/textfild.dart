import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SbtTextfildSifre extends StatelessWidget {
  String hintText;
  TextEditingController textEditingController;
  SbtTextfildSifre(
      {super.key, required this.hintText, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textEditingController,
        obscureText: true,
        decoration: InputDecoration(
          label: Text(hintText),
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SbtTextfild extends StatelessWidget {
  String hintText;
  TextEditingController textEditingController;
  SbtTextfild(
      {super.key, required this.hintText, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
        maxLength: 11,
        decoration: InputDecoration(
          label: Text(hintText),
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SbtTextfild2 extends StatelessWidget {
  String hintText;
  TextEditingController textEditingController;
  SbtTextfild2(
      {super.key, required this.hintText, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          label: Text(hintText),
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
