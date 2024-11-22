import 'package:flutter/material.dart';

class TulisCerita extends StatelessWidget {
  const TulisCerita({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tulis Ceritamu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        centerTitle: true, // Memastikan teks berada di tengah
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Action untuk kembali
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 100),
            Center(
              child: Column(
                children: [
                  Text(
                    'Dari kota mana kamu pergi?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20), // Menambahkan jarak antara teks dan gambar
                  Image.asset(
                    'assets/images/p.png', // Pastikan ilustrasi sesuai
                    height: 202, // Sesuaikan ukuran gambar
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            // Menggunakan Container untuk mengatur ukuran TextField
            Container(
              width: 303,
              height: 30, // Mengatur tinggi TextField
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Input kota yang telah dikunjungi?',
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: 303,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    // Action untuk tombol
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF277BC0), // Warna tombol
                    foregroundColor: Colors.white, // Mengubah warna font tombol menjadi hitam
                  ),
                  child: Text(
                    'Buat Cerita',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
