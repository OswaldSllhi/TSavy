import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_savy/controllers/itinerary_controller.dart';
import 'itinerary_list.dart';

class ItinerarySchedulePage extends StatelessWidget {
  final int itineraryId;
  final ItineraryController itineraryController = Get.find<ItineraryController>();

  ItinerarySchedulePage({required this.itineraryId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!itineraryController.fetchedItineraryIds.contains(itineraryId)) {
        itineraryController.fetchItinerary(itineraryId);
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: const Text(
          'My Itinerary',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (itineraryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (itineraryController.errorMessage.isNotEmpty) {
          return Center(child: Text(itineraryController.errorMessage.value));
        }

        final itinerary = itineraryController.itineraries.firstWhere(
          (itinerary) => itinerary['id'] == itineraryId,
          orElse: () => null,
        );

        if (itinerary == null) {
          return const Center(child: Text('No itinerary found.'));
        }

        final days = itinerary['itinerary_details']
                ?.map((detail) => detail['day'])
                ?.toSet()
                ?.toList()
                ?.cast<int>() ?? [];
        days.sort();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/wisata/${itinerary["id"]}.jpg',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itinerary['city'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        itinerary['name'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Schedule',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  return ItineraryDayCard(
                    day: 'Day $day',
                    onTap: () {
                      Get.to(() => ItineraryListPage(
                        itineraryId: itineraryId,
                        day: day,
                      ));
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

class ItineraryDayCard extends StatelessWidget {
  final String day;
  final VoidCallback onTap;

  const ItineraryDayCard({
    required this.day,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.blue[700],
      child: ListTile(
        title: Text(
          day,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }
}
