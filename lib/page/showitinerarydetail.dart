import 'package:flutter/material.dart';

class ShowItineraryDetailPage extends StatelessWidget {
  final Map<String, dynamic> itinerary;

  ShowItineraryDetailPage({required this.itinerary});

  @override
  Widget build(BuildContext context) {
    final itineraryDetails = itinerary['itinerary_details'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(itinerary['name'] ?? 'Itinerary Details'),
      ),
      body: ListView.builder(
        itemCount: itineraryDetails.length,
        itemBuilder: (context, index) {
          final detail = itineraryDetails[index];
          final wisata = detail['wisata'];

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Day ${detail['day']}: ${wisata['name'] ?? 'Unknown Place'}"),
              subtitle: Text(wisata['description'] ?? 'No description'),
              leading: SizedBox(
                width: 80,
                height: 80,
                child: Image.network(
                  wisata['image'] ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
