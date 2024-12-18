
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_savy/constants/constants.dart';

class CategoryController extends GetxController {
  var categories = [].obs;
  var isLoading = false.obs;

  Future<void> fetchCategories() async {
    isLoading.value = true;

    try {
      final token = getToken();
      if (token == null) {
        Get.snackbar('Error', 'Token tidak ditemukan. Silakan login ulang.');
        return;
      }

      final response = await http.get(
        Uri.parse('${baseUrl}categories'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        
        // Asumsikan API mengembalikan list langsung
        categories.value = (result as List).map((category) {
          return {
            'id': category['id'],
            'name': category['name'],
            'created_at': category['created_at'],
            'updated_at': category['updated_at'],
          };
        }).toList();

        print('Kategori berhasil dimuat: $categories');
      } else {
        Get.snackbar(
          'Error',
          'Gagal memuat data kategori: ${response.statusCode}\n${response.body}',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
