import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_savy/constants/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_savy/page/home_screen.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  
  final token = ''.obs;
  final box = GetStorage();

  // Fungsi register
  Future<void> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      
      var data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      };

      var response = await http.post(
        Uri.parse(url + 'register'), // URL register API
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        debugPrint('Register Success: ${json.decode(response.body)}');
        
        var responseData = json.decode(response.body);
        token.value = responseData['token'];

        // Menyimpan token di GetStorage
        box.write('token', token.value);

        // Log token yang disimpan
        debugPrint("Token after registration: ${box.read('token')}");

        // Gunakan Future.delayed untuk memberi waktu sebelum navigasi ke HomeScreen
        Future.delayed(Duration(seconds: 1), () {
          // Pastikan HomeScreen diimpor dengan benar
          Get.offAll(() => HomeScreen());
        });

        // Menampilkan snackbar untuk memberi tahu user
        Get.snackbar('Success', 'User registered successfully!',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        // Jika API mengembalikan status selain 201, tampilkan pesan error
        debugPrint('Register Error: ${json.decode(response.body)}');
        Get.snackbar('Error', 'Failed to register user.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      debugPrint('Exception: ${e.toString()}');
      Get.snackbar('Error', 'Something went wrong.',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Reset loading state setelah request
    }
  }
  // Fungsi login
  Future<void> login({
    required String username,
    required String password,
  }) async {
    isLoading.value = true;  // Mengatur status loading

    try {
      // Membuat data request
      var data = {
        'username': username,
        'password': password,
      };

      // URL API untuk login
      var response = await http.post(
        Uri.parse('https://example.com/login'), // Gantilah dengan URL login Anda
        headers: {'Accept': 'application/json'},
        body: data,
      );

      // Mengecek status response
      if (response.statusCode == 200) {
        // Menyimpan response ke dalam variabel
        var responseData = json.decode(response.body);

        // Mengecek apakah response berisi token
        if (responseData.containsKey('token')) {
          // Menyimpan token di GetStorage
          token.value = responseData['token'];
          box.write('token', token.value); // Menyimpan token secara persisten

          // Debugging: Menampilkan token yang baru disimpan
          debugPrint("Token berhasil disimpan: ${box.read('token')}");

          // Navigasi ke HomeScreen setelah login sukses
          Get.offAll(() => HomeScreen());

          // Tampilkan snackbar untuk sukses login
          Get.snackbar('Login Success', 'Welcome, ${responseData['user']['name']}!',
              snackPosition: SnackPosition.BOTTOM);
        } else {
          // Jika token tidak ada dalam response, tampilkan pesan error
          Get.snackbar('Login Failed', 'No token found in the response.',
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        // Jika status bukan 200, tampilkan pesan error
        Get.snackbar('Login Failed', 'Invalid credentials.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      // Tangani error jika terjadi exception pada request
      debugPrint('Exception: ${e.toString()}');
      Get.snackbar('Login Failed', 'An error occurred while logging in.',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;  // Reset status loading setelah selesai
    }
  }

}
