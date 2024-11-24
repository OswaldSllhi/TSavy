import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_savy/page/auth/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Navigasi ke LoginPage setelah 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF277BC0),
                  Color(0xFF071952),
                ],
              ),
            ),
          ),

          // Logo di tengah
          Positioned(
            top: 0,
            left: -13,
            child: SizedBox(
              width: 175,
              height: 175,
              child: Image.asset('assets/images/bulatatas.png'),
            ),
          ),

          // Logo di tengah
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 276,
              height: 191,
            ),
          ),

          // Bulat bawah di kanan bawah dengan ukuran lebih kecil
          Positioned(
            bottom: 0,
            right: -32,
            child: SizedBox(
              width: 120,
              height: 200,
              child: Image.asset('assets/images/bulatbawah.png'),
            ),
          ),
        ],
      ),
    );
  }
}
