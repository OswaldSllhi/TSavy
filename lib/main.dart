import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_savy/page/auth/login.dart';
import 'package:travel_savy/page/auth/register.dart';
import 'package:travel_savy/page/profile_dashboard.dart';
import 'package:travel_savy/page/splash.dart';
import 'package:travel_savy/page/tulis_cerita.dart';
import '../controllers/CityController.dart';
import 'package:travel_savy/page/splash_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 57, 123, 246)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
