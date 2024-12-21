import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_savy/controllers/itinerary_controller.dart';
import 'showitinerarydetail.dart';

class ShowItineraryPage extends StatelessWidget {
  final ItineraryController controller = Get.find<ItineraryController>();

  ShowItineraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Itinerary Page"),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.itineraries.isEmpty) {
          return const Center(child: Text("No itineraries found."));
        } else {
          return ListView.builder(
            itemCount: controller.itineraries.length,
            itemBuilder: (context, index) {
              final itinerary = controller.itineraries[index];
              return ListTile(
                title: Text(itinerary['name'] ?? 'No Name'),
                subtitle: Text(itinerary['city_deskripsi'] ?? 'No Description'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Arahkan ke halaman detail itinerary
                  Get.to(() => ShowItineraryDetailPage(itinerary: itinerary));
                },
              );
            },
          );
        }
      }),
    );
  }
}
