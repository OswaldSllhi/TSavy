import 'package:flutter/material.dart';

class HalamanKota extends StatelessWidget {
  const HalamanKota({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                // Penyesuaian ukuran gambar sesuai Pixel 8a
                Image.asset(
                  'assets/images/tes.png',
                  height: 280, // Tinggi gambar disesuaikan
                  width: double.infinity, // Lebar mengikuti ukuran layar
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  bottom: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shibuya',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Japan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xFF277BC0), // Warna utama
                    ),
                    icon: const Icon(Icons.flight_takeoff, color: Colors.white),
                    label: const Text(
                      'Mulai Perjalananmu',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF277BC0)), // Border warna utama
                    ),
                    icon: const Icon(Icons.book, color: Color(0xFF277BC0)),
                    label: const Text(
                      'Tulis Ceritamu',
                      style: TextStyle(color: Color(0xFF277BC0), fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Bagian Informasi Perjalanan dengan background khusus
                  Container(
                    height: 131, // Tinggi container
                    width: MediaQuery.of(context).size.width, // Selebar layar
                    color: const Color(0xFF277BC0), // Warna dasar
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Informasi Perjalanan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Warna teks putih
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _iconInfo('Panduan'),
                            _iconInfo('Hukum'),
                            _iconInfo('Informasi'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/tes.png',
                              width: 80, // Disesuaikan untuk proporsi item
                              height: 75,
                              fit: BoxFit.cover,
                            ),
                            title: const Text(
                              'Nezu Museum',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: const Text(
                              'Paragraph of text Paragraph of text Paragraph of text',
                            ),
                            trailing: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star, color: Colors.orange, size: 16),
                                    Text('4.3'),
                                  ],
                                ),
                                Text('(6068)', style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconInfo(String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white, // Lingkaran putih
          child: Image.asset(
            'assets/images/kiw.png', // Ikon khusus kiw.png
            width: 30, // Ukuran ikon
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(color: Colors.white), // Warna teks putih
        ),
      ],
    );
  }
}
