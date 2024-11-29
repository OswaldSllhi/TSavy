import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import '../controllers/ceritacontroller.dart';

class TulisCerita extends StatefulWidget {
  @override
  _TulisCeritaState createState() => _TulisCeritaState();
}

class _TulisCeritaState extends State<TulisCerita> {
  final _judulController = TextEditingController();
  final _ceritaController = TextEditingController();
  String? _selectedKota;
  final ceritacontroller ceritaController = Get.find();

  @override
  void initState() {
    super.initState();
    ceritaController.fetchCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tulis Cerita')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _judulController,
              decoration: InputDecoration(
                labelText: 'Judul Cerita',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ceritaController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Isi Cerita',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Obx(() {
              return DropdownSearch<String>(
                items: ceritaController.cities
                    .map((city) => city['name'].toString())
                    .toList(),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: 'Pilih Kota',
                    border: OutlineInputBorder(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedKota = value;
                  });
                },
                selectedItem: _selectedKota,
              );
            }),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_judulController.text.isNotEmpty &&
                    _ceritaController.text.isNotEmpty &&
                    _selectedKota != null) {
                  int cityId = ceritaController.cities
                      .firstWhere((city) => city['name'] == _selectedKota)['id'];

                  bool success = await ceritaController.addCerita(
                    title: _judulController.text,
                    content: _ceritaController.text,
                    cityId: cityId,
                  );

                  if (success) {
                    Navigator.pop(context);
                  }
                } else {
                  Get.snackbar('Error', 'Mohon lengkapi semua field');
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
