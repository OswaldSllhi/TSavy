import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:travel_savy/constants/constants.dart';

class ItineraryController extends GetxController {
  var itineraries = [].obs; // Daftar itinerary
  var isLoading = false.obs; // Status loading
  var errorMessage = ''.obs; // Pesan error
  var fetchedItineraryIds = <int>{}; // Cache ID itinerary yang sudah diambil

  // Mengambil semua itinerary beserta relasi
Future<void> fetchItineraries() async {
  if (itineraries.isNotEmpty) return; // Cegah pengambilan ulang jika sudah ada data
  isLoading.value = true;

  try {
    final token = getToken();
    final response = await http.get(
      Uri.parse('${baseUrl}itineraries'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['success'] == true) {
        itineraries.value = (result['itineraries'] as List).map((itinerary) {
          return {
            'id': itinerary['id'],
            'name': itinerary['name'],
            'city': itinerary['city'],
            'city_deskripsi': itinerary['city_deskripsi'],
            'departure_date': formatDate(itinerary['departure_date']),
            'return_date': formatDate(itinerary['return_date']),
            'itinerary_details': (itinerary['itinerary_details'] as List).map((detail) {
              return {
                'day': detail['day'],
                'wisata': detail['wisata'],
              };
            }).toList(),
          };
        }).toList();
      } else {
        errorMessage.value = 'Error: ${result['message']}';
      }
    } else {
      errorMessage.value = 'Error: ${response.statusCode} - ${response.body}';
    }
  } catch (e) {
    errorMessage.value = 'Error: $e';
  } finally {
    isLoading.value = false;
  }
}


  // Generate itinerary baru
  Future<void> generateItinerary({
    required int cityId,
    required List<int> categories,
    required int price,
    required String departureDate,
    required String returnDate,
  }) async {
    isLoading.value = true;

    try {
      final token = getToken();
      final response = await http.post(
        Uri.parse('${baseUrl}itineraries/generate'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'city_id': cityId,
          'categories': categories,
          'price': price,
          'departure_date': departureDate,
          'return_date': returnDate,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true) {
          itineraries.add(result['itinerary']);
        } else {
          errorMessage.value = 'Error: ${result['message']}';
        }
      } else {
        errorMessage.value = 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Mengambil itinerary berdasarkan ID dengan detailnya
  Future<Map<String, dynamic>?> getItineraryById(int id) async {
    try {
      final token = getToken();
      final response = await http.get(
        Uri.parse('${baseUrl}itineraries/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true) {
          return result['itinerary'];
        } else {
          errorMessage.value = 'Error: ${result['message']}';
        }
      } else {
        errorMessage.value = 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    }
    return null;
  }

  // Mengambil itinerary berdasarkan ID
  Future<void> fetchItinerary(int id) async {
    if (fetchedItineraryIds.contains(id)) return; // Cegah pengambilan ulang jika sudah di-cache
    isLoading.value = true;

    try {
      final token = getToken();
      final response = await http.get(
        Uri.parse('${baseUrl}itineraries/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true) {
          final itinerary = result['itinerary'];
          itineraries.add(itinerary);
          fetchedItineraryIds.add(id); // Tandai ID itinerary yang sudah diambil
        } else {
          errorMessage.value = 'Error: ${result['message']}';
        }
      } else {
        errorMessage.value = 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Update itinerary
  Future<void> updateItinerary({
    required int id,
    required Map<String, dynamic> updates,
  }) async {
    isLoading.value = true;

    try {
      final token = getToken();
      final response = await http.put(
        Uri.parse('${baseUrl}itineraries/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updates),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true) {
          itineraries.value = [result['itinerary']];
        } else {
          errorMessage.value = 'Error: ${result['message']}';
        }
      } else {
        errorMessage.value = 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Hapus itinerary
  Future<void> deleteItinerary(int id) async {
    isLoading.value = true;

    try {
      final token = getToken();
      final response = await http.delete(
        Uri.parse('${baseUrl}itineraries/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true) {
          itineraries.removeWhere((itinerary) => itinerary['id'] == id);
        } else {
          errorMessage.value = 'Error: ${result['message']}';
        }
      } else {
        errorMessage.value = 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate(String date) {
  final months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  try {
    final parts = date.split('-'); // Format: YYYY-MM-DD
    final year = parts[0];
    final month = int.parse(parts[1]);
    final day = parts[2];

    return '$day ${months[month - 1]} $year';
  } catch (e) {
    return date; // Jika gagal, kembalikan format asli
  }
}

}
