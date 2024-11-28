import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../constants/constants.dart';

class CeritaController extends GetxController {
  var isLoading = false.obs; // Observable untuk status loading
  var ceritas = <Map<String, dynamic>>[].obs; // Observable untuk daftar cerita
  final box = GetStorage();

  // Fungsi untuk mengambil cerita dari API
  Future<void> fetchCeritas() async {
    try {
      isLoading.value = true; // Set loading ke true
      final response = await http.get(
        Uri.parse('${url}ceritas'), // Pastikan endpoint API benar
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}', // Jika menggunakan token
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ceritas.value = List<Map<String, dynamic>>.from(data['data']);
      } else {
        Get.snackbar('Error', 'Gagal memuat data cerita');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false; // Set loading ke false
    }
  }

  /// Tambahkan cerita baru
  Future<bool> addCerita({
    required String title,
    required String content,
    String? imagePath,
  }) async {
    try {
      final String? token = box.read('token');

      if (token == null) {
        Get.snackbar('Error', 'No token found, please login again.');
        return false;
      }

      var request = http.MultipartRequest('POST', Uri.parse('${url}ceritas'));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['title'] = title;
      request.fields['content'] = content;

      if (imagePath != null) {
        request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        debugPrint('Cerita berhasil ditambahkan.');
        return true;
      } else {
        debugPrint('Failed to add story: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Error adding story: $e');
      return false;
    }
  }

  /// Hapus cerita
  Future<bool> deleteCerita(int id) async {
    try {
      final String? token = box.read('token');

      if (token == null) {
        Get.snackbar('Error', 'No token found, please login again.');
        return false;
      }

      var response = await http.delete(
        Uri.parse('${url}ceritas/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Cerita berhasil dihapus.');
        return true;
      } else {
        debugPrint('Failed to delete story: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error deleting story: $e');
      return false;
    }
  }
}
