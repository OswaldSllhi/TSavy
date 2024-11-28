import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../constants/constants.dart';

class CityController extends GetxController {
  var cities = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs; // Define isLoading as an observable variable

  // Fetch cities from the API
  Future<void> fetchCities() async {
    try {
      final response = await http.get(
        Uri.parse('${url}cities'),
        headers: {
          'Accept': 'application/json',
        },
      );

      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null) {
          // Update the field names to match the API response
          cities.value =
              List<Map<String, dynamic>>.from(data['data'].map((city) => {
                    'name': city['city_name'], // Mapping 'city_name' to 'name'
                    'image':
                        city['image_url'], // Mapping 'image_url' to 'image'
                    'id': city['id'], // Keep the city 'id'
                  }));
          print('Cities fetched: ${cities.value}');
        } else {
          Get.snackbar('Error', 'Data kota tidak ditemukan');
        }
      } else {
        Get.snackbar('Error', 'Gagal memuat data kota');
      }
    } catch (e) {
      print('Error fetching cities: $e');
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }
}
