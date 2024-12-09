import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_savy/constants/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_savy/page/home_screen.dart';
import 'package:travel_savy/page/splash.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
  
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
        Uri.parse(baseUrl + 'register'), // URL register API
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
            snackPosition: SnackPosition.TOP);
      } else {
        // Jika API mengembalikan status selain 201, tampilkan pesan error
        debugPrint('Register Error: ${json.decode(response.body)}');
        Get.snackbar('Error', 'Failed to register user.',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      debugPrint('Exception: ${e.toString()}');
      Get.snackbar('Error', 'Something went wrong.',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false; // Reset loading state setelah request
    }
  }

Future<void> login({
  required String username,
  required String password,
  required bool rememberMe, // Tambahkan parameter rememberMe
}) async {
  try {
    isLoading.value = true; // Tampilkan loading indicator

    var data = {
      'username': username,
      'password': password,
    };

    var response = await http.post(
      Uri.parse('${baseUrl}login'),
      headers: {
        'Accept': 'application/json',
      },
      body: data,
    );

if (response.statusCode == 200) {
  var responseData = json.decode(response.body);

  if (responseData.containsKey('token')) {
    token.value = responseData['token'];

    // Simpan informasi user di GetStorage
    box.write('token', token.value);
    box.write('user', responseData['user']); // Simpan data user (seperti username)

    if (rememberMe) {
      box.write('rememberMe', true);
    }

    Get.offAll(() => HomeScreen());
  } else {
    Get.snackbar('Error', 'Login successful, but no token found.');
  }
} else {
      Get.snackbar('Error', 'Invalid username or password.');
    }
  } catch (e) {
    Get.snackbar('Error', 'Something went wrong.');
  } finally {
    isLoading.value = false;
  }
}

// fungsi logout
Future<void> logout() async {
  try {
    isLoading.value = true;

    final String? storedToken = box.read('token');
    if (storedToken == null) {
      // Handle the case when no token is found (user might already be logged out)
      debugPrint("No token found");
      Get.snackbar('Error', 'You are already logged out.');
      return;
    }

    // Send logout request to the backend
    var response = await http.post(
      Uri.parse('${baseUrl}logout'), // Replace with your correct logout URL
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $storedToken',
      },
    );

    if (response.statusCode == 200) {
      // Clear token on successful logout
      box.remove('token');
      token.value = '';

      // Navigate to the SplashPage
      Get.offAll(() => SplashPage());
    } else {
      debugPrint('Logout failed with status code: ${response.statusCode}');
      debugPrint('Response: ${response.body}');
      Get.snackbar('Error', 'Failed to logout',
          snackPosition: SnackPosition.TOP);
    }
  } catch (e) {
    debugPrint('Logout Exception: $e');
    Get.snackbar('Error', 'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.TOP);
  } finally {
    isLoading.value = false;
  }
}


}
