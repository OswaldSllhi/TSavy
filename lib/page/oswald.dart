import 'package:flutter/material.dart';

class OswaldPage extends StatelessWidget {
  const OswaldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CenterPage(),
    );
  }
}

class CenterPage extends StatelessWidget {
  const CenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum Pemrograman Mobile'),
        centerTitle: true,
        backgroundColor: const Color(0xFF277BC0), 
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF277BC0), 
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Oswald Adrian Silalahi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, 
                ),
              ),
              SizedBox(height: 10),
              Text(
                '221402082',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

