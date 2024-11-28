import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../controllers/CityController.dart'; // Import CityController
import '../controllers/ceritacontroller.dart'; // Import CeritaController

class TulisCerita extends StatefulWidget {
  @override
  _TulisCeritaState createState() => _TulisCeritaState();
}

class _TulisCeritaState extends State<TulisCerita> {
  final _judulController = TextEditingController();
  final _ceritaController = TextEditingController();
  String? _selectedKota;
  final CityController _cityController = Get.find(); // Fetch CityController
  final CeritaController _ceritaControllerObj = Get.find(); // Fetch CeritaController

  @override
  void initState() {
    super.initState();
    // Fetch cities when the screen is initialized
    _cityController.fetchCities();
  }

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
      body: Obx(() {
        // Observe the loading state of the cities
        if (_cityController.isLoading.value) {
          return Center(child: CircularProgressIndicator()); // Show loading if isLoading is true
        } else if (_cityController.cities.isEmpty) {
          return Center(child: Text("No cities available.")); // Show message if no cities are fetched
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Input Judul (Title)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _judulController,
                    decoration: InputDecoration(
                      labelText: 'Judul Cerita',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Dropdown for cities
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                    ),
                    items: _cityController.cities
                        .map((city) => city['name'] as String)
                        .toList(),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Pilih Kota',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    selectedItem: _selectedKota,
                    onChanged: (value) {
                      setState(() {
                        _selectedKota = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),

                // Input Cerita (Story Content)
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

                // Tombol Submit (Submit Button)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final judul = _judulController.text;
                        final cerita = _ceritaController.text;

                        // Validate input fields
                        if (judul.isEmpty || _selectedKota == null || cerita.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Harap isi semua bidang!'),
                            ),
                          );
                        } else {
                          // Find the city ID based on the selected city
                          final cityId = _cityController.cities.firstWhere(
                                  (city) => city['name'] == _selectedKota)['id']
                              as int;

                          // Call CeritaController to submit the story
                          final success = await _ceritaControllerObj.addCerita(
                            title: judul,
                            content: cerita,
                            cityId: cityId,
                          );

                          // Show success or failure message
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Cerita berhasil disubmit!'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Gagal mengirim cerita.'),
                              ),
                            );
                          }
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
          );
        }
      }),
    );
  }
}
