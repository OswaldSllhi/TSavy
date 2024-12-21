import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_savy/constants/constants.dart'; // Pastikan baseUrl sudah benar
import '../models/itinerary_model.dart';

class ItineraryService {

  // Fetch all itineraries
  Future<List<Itinerary>> fetchItineraries() async {
    try {
      final token = getToken(); // Fungsi untuk mengambil token
      final response = await http.get(
        Uri.parse('$baseUrl/itineraries'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['data'] as List)
            .map((item) => Itinerary.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load itineraries');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch a specific itinerary by ID
  Future<Itinerary> fetchItinerary(int id) async {
    try {
      final token = getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/itineraries/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Itinerary.fromJson(data['data']);
      } else {
        throw Exception('Failed to load itinerary');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Generate a new itinerary
  Future<Itinerary> generateItinerary({
    required int cityId,
    required List<int> categories,
    required int days,
    required int price,
  }) async {
    try {
      final token = getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/itineraries/generate'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'city_id': cityId,
          'categories': categories,
          'days': days,
          'price': price,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Itinerary.fromJson(data['data']);
      } else {
        throw Exception('Failed to generate itinerary');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Update an existing itinerary
  Future<void> updateItinerary(int id, Map<String, dynamic> updates) async {
    try {
      final token = getToken();
      final response = await http.put(
        Uri.parse('$baseUrl/itineraries/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updates),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update itinerary');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Delete an itinerary
  Future<void> deleteItinerary(int id) async {
    try {
      final token = getToken();
      final response = await http.delete(
        Uri.parse('$baseUrl/itineraries/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete itinerary');
      }
    } catch (e) {
      rethrow;
    }
  }
}
