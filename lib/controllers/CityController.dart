import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:travel_savy/constants/constants.dart';

class CityController extends GetxController {
  var cities = [].obs;
  var isLoading = false.obs;

  Future<void> fetchCities() async {
    isLoading.value = true;

    try {
      final token = getToken();
      final response = await http.get(
        Uri.parse('${baseUrl}cities'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true) {
          cities.value = result['data'];
        } else {
          Get.snackbar('Error', 'Respon API gagal: ${result['message']}');
        }
      } else {
        Get.snackbar(
          'Error',
          'Gagal memuat data kota: ${response.statusCode}\n${response.body}',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
