import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_savy/page/auth/login.dart';
import 'package:travel_savy/page/auth/register.dart';
import 'package:travel_savy/page/oswald.dart';
import 'package:travel_savy/page/profile_dashboard.dart';
import 'package:travel_savy/page/splash.dart';
import 'package:travel_savy/page/tulis_cerita.dart';
import '../controllers/CityController.dart'; // Import CityController

void main() async {
  await GetStorage.init(); // Initialize GetStorage
  Get.put(CityController()); // Register CityController globally
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}
