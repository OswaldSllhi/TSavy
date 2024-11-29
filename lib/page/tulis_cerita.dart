import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:travel_savy/controllers/ceritacontroller.dart';
import 'package:travel_savy/controllers/CityController.dart'; // Controller untuk kota

class TulisCerita extends StatefulWidget {
  @override
  _TulisCeritaState createState() => _TulisCeritaState();
}

class _TulisCeritaState extends State<TulisCerita> {
  final _judulController = TextEditingController();
  final _ceritaController = TextEditingController();
  String? _selectedKota;

  final CityController cityController = Get.put(CityController());
  final ceritacontroller ceritaController = Get.put(ceritacontroller());

  @override
  void initState() {
    super.initState();
    cityController.fetchCities();
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
              if (cityController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return DropdownSearch<String>(
                items: cityController.cities
                    .map((city) => city['city_name'].toString())
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
                  int cityId = cityController.cities
                      .firstWhere((city) => city['city_name'] == _selectedKota)['id'];

                  // Gunakan CeritaController untuk menambah cerita
                  bool success = await ceritaController.addCerita(
                    title: _judulController.text,
                    content: _ceritaController.text,
                    cityId: cityId,
                  );

                  if (success) {
                    Get.snackbar('Success', 'Cerita berhasil ditambahkan');
                    Navigator.pop(context);
                  } else {
                    Get.snackbar('Error', 'Gagal menambahkan cerita');
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
