import 'package:get_storage/get_storage.dart';

// URL API base
const String baseUrl = 'http://192.168.1.5:80/api/';

// Fungsi untuk mendapatkan token dari GetStorage
String? getToken() {
  final box = GetStorage();
  return box.read('token'); // Mengambil token yang disimpan
}
