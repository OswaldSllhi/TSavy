import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class TulisCerita extends StatefulWidget {
  @override
  _TulisCeritaState createState() => _TulisCeritaState();
}

class _TulisCeritaState extends State<TulisCerita> {
  final _judulController = TextEditingController();
  final _ceritaController = TextEditingController();
  String? _selectedKota;

  final List<String> _daftarKota = [
    'Jakarta',
    'Bandung',
    'Surabaya',
    'Yogyakarta',
    'Bali',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Header
            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //     image: DecorationImage(
            //       image: AssetImage('assets/images/kuning.png'), // Path gambar
            //       alignment: Alignment.topRight,
            //     ),
            //   ),
            //   padding: const EdgeInsets.all(16.0),
            //   // Konten teks tetap di sini...
            // ),

            Container(
              color: Colors.blue,
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Ayo Bercerita',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '#BersamaTravelSavy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Input Judul
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _judulController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Dropdown Kota
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownSearch<String>(
                popupProps: PopupProps.menu(
                  showSearchBox: true, // Menambahkan kotak pencarian
                ),
                items: _daftarKota, // Daftar kota
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: 'Kota',
                    border: OutlineInputBorder(),
                  ),
                ),
                selectedItem: _selectedKota, // Kota terpilih
                onChanged: (value) {
                  setState(() {
                    _selectedKota = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),

            // Input Cerita
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _ceritaController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Ceritakan semuanya!',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Tombol Submit
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final judul = _judulController.text;
                    final cerita = _ceritaController.text;

                    if (judul.isEmpty || _selectedKota == null || cerita.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Harap isi semua bidang!'),
                        ),
                      );
                    } else {
                      // Tambahkan logika untuk submit data
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Cerita berhasil disubmit!'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
