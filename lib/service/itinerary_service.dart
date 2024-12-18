import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/itinerary_model.dart';
import 'package:travel_savy/constants/constants.dart';

class ItineraryService {
// Ganti dengan URL API Laravel Anda

  // Fetch all itineraries
  Future<List<Itinerary>> fetchItineraries() async {
    final response = await http.get(Uri.parse("$baseUrl/itineraries"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Itinerary.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch itineraries");
    }
  }

  // Show a specific itinerary
  Future<Itinerary> fetchItinerary(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/itineraries/$id"));

    if (response.statusCode == 200) {
      return Itinerary.fromJson(json.decode(response.body)['itinerary']);
    } else {
      throw Exception("Failed to fetch itinerary");
    }
  }

  // Generate a new itinerary
  Future<Itinerary> generateItinerary({
    required int cityId,
    required List<int> categories,
    required int days,
    required int price,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/itineraries/generate"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'city_id': cityId,
        'categories': categories,
        'days': days,
        'price': price,
      }),
    );

    if (response.statusCode == 200) {
      return Itinerary.fromJson(json.decode(response.body)['itinerary']);
    } else {
      throw Exception("Failed to generate itinerary: ${response.body}");
    }
  }
}
