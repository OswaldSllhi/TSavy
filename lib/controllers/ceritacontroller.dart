import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:travel_savy/page/rekamperjalanan.dart';
import '../constants/constants.dart';

class ceritacontroller extends GetxController {
  var cities = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var ceritas = <Map<String, dynamic>>[].obs;
  final box = GetStorage();

  // Fetch cities data
  Future<void> fetchCities() async {
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}cities'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data'] is List) {
          cities.value = List<Map<String, dynamic>>.from(data['data'].map((city) => {
                'id': city['id'],
                'name': city['city_name'], // Pastikan sesuai dengan key API
              }));
        } else {
          Get.snackbar('Error', 'Data kota tidak ditemukan');
        }
      } else {
        Get.snackbar('Error', 'Gagal memuat data kota');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }

  // Fetch cerita data
Future<void> fetchCeritas() async {
  try {
    isLoading.value = true;
    final response = await http.get(
      Uri.parse('${baseUrl}ceritas'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      ceritas.value = List<Map<String, dynamic>>.from(data['data'].map((story) {
        return {
          'id': story['id'],
          'title': story['title'],
          'content': story['content'],
          'image': story['image'],
          'city': story['city'], // Tambahkan data city
        };
      }));
    } else {
      Get.snackbar('Error', 'Gagal memuat data cerita');
    }
  } catch (e) {
    Get.snackbar('Error', 'Terjadi kesalahan: $e');
  } finally {
    isLoading.value = false;
  }
}


  // Add cerita
  Future<bool> addCerita({
    required String title,
    required String content,
    String? imagePath,
    required int cityId,
  }) async {
    try {
      final String? token = box.read('token');

      if (token == null) {
        Get.snackbar('Error', 'No token found, please login again.');
        return false;
      }

      var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}ceritas'));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['city_id'] = cityId.toString();

      if (imagePath != null) {
        request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Cerita berhasil ditambahkan');
        fetchCeritas(); // Perbarui daftar cerita
        return true;
      } else {
        final resBody = await response.stream.bytesToString();
        debugPrint('Failed to add story: $resBody');
        Get.snackbar('Error', 'Gagal menambahkan cerita');
        return false;
      }
    } catch (e) {
      debugPrint('Error adding story: $e');
      return false;
    }
  }

// delete cerita
Future<bool> destroyCerita(int ceritaId, BuildContext context) async {
  try {
    final String? token = box.read('token');
    
    if (token == null) {
      Get.snackbar('Error', 'No token found, please login again.');
      return false;
    }

    final response = await http.delete(
      Uri.parse('${baseUrl}ceritas/$ceritaId'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      Get.snackbar('Success', 'Cerita berhasil dihapus');
      fetchCeritas(); // Perbarui daftar cerita

      // Kembali ke halaman utama (rekam perjalanan)
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
        (route) => false, // Menutup semua halaman sebelumnya
      );


      return true;
    } else {
      debugPrint('Failed to delete story: ${response.body}');
      Get.snackbar('Error', 'Gagal menghapus cerita');
      return false;
    }
  } catch (e) {
    debugPrint('Error deleting story: $e');
    return false;
  }
}


}
