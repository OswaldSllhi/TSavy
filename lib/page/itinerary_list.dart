import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_savy/controllers/itinerary_controller.dart';

class ItineraryListPage extends StatelessWidget {
  final int itineraryId;
  final int day;
  final ItineraryController controller = Get.find<ItineraryController>();

  ItineraryListPage({required this.itineraryId, required this.day});

  @override
  Widget build(BuildContext context) {
    controller.fetchItinerary(itineraryId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Day $day Itinerary'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final itinerary = controller.itineraries.firstWhere(
          (itinerary) => itinerary['id'] == itineraryId,
          orElse: () => null,
        );

        if (itinerary == null) {
          return const Center(child: Text('No itinerary found.'));
        }

        final itineraryDetails = itinerary['itinerary_details']
                ?.where((detail) => detail['day'] == day)
                ?.toList() ??
            [];

        if (itineraryDetails.isEmpty) {
          return const Center(child: Text('No activities found for this day.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: itineraryDetails.length,
          itemBuilder: (context, index) {
            final detail = itineraryDetails[index];
            final wisata = detail['wisata'] ?? {};

            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/wisata/${wisata["id"]}.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
                title: Text(wisata['name'] ?? 'No Name'),
                subtitle: Text(wisata['description'] ?? 'No Description'),
                onTap: () {
                  // Tambahkan aksi jika diperlukan
                },
              ),
            );
          },
        );
      }),
    );
  }
}
