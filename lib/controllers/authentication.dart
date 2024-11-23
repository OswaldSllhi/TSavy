import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:travel_savy/constants/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_savy/page/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true; // Tampilkan loading indicator

      // Data yang dikirim ke API
      var data = {
        'username': username,
        'password': password,
      };

      // Kirim permintaan POST ke endpoint login
      var response = await http.post(
        Uri.parse('${url}login'), // Pastikan URL valid
        headers: {
          'Accept': 'application/json', // Header yang diperlukan API
        },
        body: data,
      );

      // Periksa status respons
      if (response.statusCode == 200) {
        // Parsing respons JSON
        var responseData = json.decode(response.body);

        // Simpan token jika tersedia
        if (responseData.containsKey('token')) {
          token.value = responseData['token'];
          box.write('token', token.value);

          debugPrint("Token: ${box.read('token')}");

          // Navigasi ke HomeScreen
          Get.offAll(() => HomeScreen());
        } else {
          Get.snackbar(
            'Error',
            'Login successful, but no token found.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else if (response.statusCode == 401) {
        // Kredensial salah
        Get.snackbar(
          'Error',
          'Invalid username or password.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        // Respons lainnya
        var errorMessage =
            json.decode(response.body)['message'] ?? 'Login failed.';
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Tangani error
      debugPrint('Login Exception: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false; // Sembunyikan loading indicator
    }
  }

//fungsi login google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) return; // User membatalkan login

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      // Kirim token ke backend Laravel
      final response = await http.post(
        Uri.parse('https://${url}/api/login/google'),
        body: {'id_token': idToken},
      );

      if (response.statusCode == 200) {
        // Berhasil login
        print('Login success: ${response.body}');
      } else {
        print('Login failed: ${response.body}');
      }
    } catch (e) {
      print('Error during Google Sign-In: $e');
    }
  }

Future<void> signInWithFacebook() async {
  try {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      // Ambil token dari hasil login
      final String accessToken = result.accessToken!.tokenString;

      // Kirim token ke backend Laravel
      final response = await http.post(
        Uri.parse('https://${url}/api/login/facebook'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'access_token': accessToken}),
      );

      if (response.statusCode == 200) {
        // Berhasil login
        print('Login success: ${response.body}');
      } else {
        // Gagal login
        print('Login failed: ${response.body}');
      }
    } else {
      // Login dibatalkan atau gagal
      print('Facebook login cancelled or failed: ${result.status}');
    }
  } catch (e) {
    print('Error during Facebook Sign-In: $e');
  }
}

}
