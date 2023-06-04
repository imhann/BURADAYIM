import 'dart:async';
import 'package:buradayim/sayfalar/admin/admin_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IslemAnimatedSayfasi extends StatefulWidget {
  const IslemAnimatedSayfasi({super.key});

  @override
  State<IslemAnimatedSayfasi> createState() => _IslemAnimatedSayfasiState();
}

class _IslemAnimatedSayfasiState extends State<IslemAnimatedSayfasi> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NewAdminSayfasi()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('İşlem Devam Ediyor...'),
      ),
      body: Center(
        child: Lottie.asset(
          'asset/image/lotti.json',
        ),
      ),
    );
  }
}
