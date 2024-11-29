import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class CityController extends GetxController {
  var cities = <Map<String, dynamic>>[].obs; // Daftar kota yang diambil dari API
  var isLoading = false.obs; // Status untuk menandakan loading

  // Fetch cities dari API
  Future<void> fetchCities() async {
    isLoading.value = true; // Mulai loading
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}cities'), // Pastikan endpoint ini benar
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data'] is List) {
          cities.value = List<Map<String, dynamic>>.from(
            data['data'].map((city) => {
              'id': city['id'], // ID kota
              'name': city['city_name'], // Nama kota
              'image': city['image'], // URL gambar kota
            }),
          );
        } else {
          Get.snackbar('Error', 'Data kota tidak ditemukan.');
        }
      } else {
        Get.snackbar('Error', 'Gagal memuat data kota.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false; // Selesai loading
    }
  }
}
