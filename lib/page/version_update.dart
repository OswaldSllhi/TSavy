import 'package:flutter/material.dart';

class VersionUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo di tengah
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo_versi.png', // Ganti dengan path gambar Anda
                  height: 300,
                  width: 300,
                ),
                Text(
                  'Versi 2.8.2',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          // Update Versi
          ListTile(
            title: Text(
              'Update Versi',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // Tambahkan logika update versi jika diperlukan
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Fitur update versi belum tersedia.'),
                ),
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
