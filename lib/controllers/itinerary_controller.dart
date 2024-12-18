import 'package:flutter/material.dart';
import 'package:travel_savy/service/itinerary_service.dart';
import '../models/itinerary_model.dart';

class ItineraryController extends ChangeNotifier {
  final ItineraryService _service = ItineraryService();

  List<Itinerary> itineraries = [];
  Itinerary? itinerary;
  bool isLoading = false;
  String? errorMessage;

  // Fetch all itineraries
  Future<void> fetchItineraries() async {
    isLoading = true;
    notifyListeners();
    try {
      itineraries = await _service.fetchItineraries();
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Fetch a specific itinerary
  Future<void> fetchItinerary(int id) async {
    isLoading = true;
    notifyListeners();
    try {
      itinerary = await _service.fetchItinerary(id);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Generate a new itinerary
  Future<void> generateItinerary({
    required int cityId,
    required List<int> categories,
    required int days,
    required int price,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      itinerary = await _service.generateItinerary(
        cityId: cityId,
        categories: categories,
        days: days,
        price: price,
      );
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
