import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:travel_savy/constants/constants.dart';

class WisataController extends GetxController {
  var wisataList = [].obs; // Menyimpan list data wisata
  var isLoading = false.obs; // Status loading untuk API call

  /// Ambil semua data wisata
  Future<void> fetchAllWisata() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}wisata'),
        headers: {'Authorization': 'Bearer YOUR_TOKEN_HERE'},
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['success'] == true && decoded['data'] != null) {
          wisataList.value = decoded['data'];
          print("All wisata list updated: ${wisataList.value}");
        } else {
          Get.snackbar("Error", "Data wisata tidak ditemukan.");
        }
      } else {
        Get.snackbar("Error", "Gagal memuat data wisata.");
      }
    } catch (e) {
      print("Error fetching all wisata: $e");
      Get.snackbar("Error", "Gagal mengambil semua data wisata.");
    } finally {
      isLoading.value = false;
    }
  }

  /// Ambil data wisata berdasarkan city_id
  Future<void> fetchWisataByCityId(int city_id) async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}wisata/city/{$city_id}'),
        headers: {'Authorization': 'Bearer YOUR_TOKEN_HERE'},
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['success'] == true && decoded['data'] != null) {
          wisataList.value = decoded['data'];
          print("Wisata list by city updated: ${wisataList.value}");
        } else {
          Get.snackbar("Error", "Data tidak ditemukan untuk kota ini.");
        }
      } else {
        Get.snackbar("Error", "Gagal memuat data wisata berdasarkan kota.");
      }
    } catch (e) {
      print("Error fetching data by city_id: $e");
      Get.snackbar("Error", "Gagal mengambil data wisata berdasarkan kota.");
    } finally {
      isLoading.value = false;
    }
  }

  /// Ambil data wisata berdasarkan category_ids
  Future<void> fetchWisataByCategoryIds(List<int> categoryIds) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/wisata/by-categories'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_TOKEN_HERE',
        },
        body: json.encode({"category_ids": categoryIds}),
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded['success'] == true && decoded['data'] != null) {
          wisataList.value = decoded['data'];
          print("Wisata list by categories updated: ${wisataList.value}");
        } else {
          Get.snackbar("Error", "Data tidak ditemukan untuk kategori ini.");
        }
      } else {
        Get.snackbar("Error", "Gagal memuat data wisata berdasarkan kategori.");
      }
    } catch (e) {
      print("Error fetching data by category_ids: $e");
      Get.snackbar(
          "Error", "Gagal mengambil data wisata berdasarkan kategori.");
    } finally {
      isLoading.value = false;
    }
  }
}
