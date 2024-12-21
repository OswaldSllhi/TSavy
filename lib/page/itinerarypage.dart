import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_savy/controllers/itinerary_controller.dart';
import 'package:travel_savy/page/itinerary_schedule.dart';
import 'package:travel_savy/page/home_screen.dart';
import 'package:travel_savy/page/rekamperjalanan.dart';
import 'package:travel_savy/page/profile_dashboard.dart';
import 'bottom_nav.dart';
import 'bottom_nav.dart'; 

class ItineraryPage extends StatefulWidget {
  const ItineraryPage({super.key});

  @override
  _ItineraryPageState createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  final ItineraryController controller = Get.put(ItineraryController());
  int selectedIndex = 2;

  // Fungsi untuk memformat tanggal dalam format "20 - 22 Desember 2024"
  String formatDateRange(String startDate, String endDate) {
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
      final startParts = startDate.split('-'); // Format: YYYY-MM-DD
      final endParts = endDate.split('-'); // Format: YYYY-MM-DD

      final startYear = startParts[0];
      final startMonth = int.parse(startParts[1]);
      final startDay = startParts[2];

      final endYear = endParts[0];
      final endMonth = int.parse(endParts[1]);
      final endDay = endParts[2];

      // Jika bulan dan tahun sama
      if (startMonth == endMonth && startYear == endYear) {
        return '$startDay - $endDay ${months[startMonth - 1]} $startYear';
      }

      // Jika bulan atau tahun berbeda
      final formattedStart = '$startDay ${months[startMonth - 1]} $startYear';
      final formattedEnd = '$endDay ${months[endMonth - 1]} $endYear';
      return '$formattedStart - $formattedEnd';
    } catch (e) {
      return '$startDate - $endDate'; // Jika gagal, tampilkan format asli
    }
  }

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    // Navigasi berdasarkan index pada BottomNavigationBar
    switch (index) {
      case 0:
        Get.to(() => HomeScreen());
        break;
      case 1:
        Get.to(() => DashboardScreen());
        break;
      case 2:
        // Tetap di halaman itinerary
        break;
      case 3:
        Get.to(() => ProfileDashboard());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Memanggil fetchItineraries saat halaman dibuka
    controller.fetchItineraries();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Itinerary',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.itineraries.isEmpty) {
          return const Center(child: Text('No itineraries found.'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: controller.itineraries.length,
            itemBuilder: (context, index) {
              final itinerary = controller.itineraries[index];
              final departureDate = itinerary['departure_date']; // Tanggal keberangkatan
              final returnDate = itinerary['return_date']; // Tanggal kepulangan

              final formattedDateRange = formatDateRange(departureDate, returnDate); // Format rentang tanggal

              return GestureDetector(
                onTap: () => Get.to(() => ItinerarySchedulePage(itineraryId: itinerary['id'])),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
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
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              itinerary['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              formattedDateRange, // Menampilkan rentang tanggal dalam format baru
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 110,
                        right: 15,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/zz.png',
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: selectedIndex,
        onTap: onTap,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigasi ke halaman untuk membuat itinerary baru
          Get.to(() => ()); // Tambahkan navigasi ke halaman yang sesuai
        },
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.add),
        label: const Text(
          'Buat Itinerary baru',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
