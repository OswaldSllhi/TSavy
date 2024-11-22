import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: EditProfilePage(),
//     );
//   }
// }

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Profil
            Text(
              'Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Foto Profil
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/your_image.jpg'), // Ganti dengan path gambar yang benar
            ),
            SizedBox(height: 20),

            // Nama Panggilan
            TextField(
              decoration: InputDecoration(labelText: 'Nama Panggilan'),
            ),
            SizedBox(height: 10),

            // Email
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),

            // Jenis Kelamin
            TextField(
              decoration: InputDecoration(labelText: 'Jenis Kelamin'),
            ),
            SizedBox(height: 10),

            // Tanggal Lahir
            TextField(
              decoration: InputDecoration(labelText: 'Tanggal Lahir'),
            ),
            SizedBox(height: 10),

            // Nomor Handphone
            TextField(
              decoration: InputDecoration(labelText: 'Nomor Handphone'),
            ),
            Spacer(),

            // Tombol Save
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi ketika tombol save ditekan
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}