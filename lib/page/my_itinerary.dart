import 'package:flutter/material.dart';
import 'package:travel_savy/page/itinerary_2.dart';
//import 'generate_itinerary.dart';
import 'package:travel_savy/page/itinerary_schedule.dart';
//import 'itinerary_schedule.dart';

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'My Itinerary',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyItinerary(),
//     );
//   }
// }

class MyItinerary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Itinerary', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Tambahkan navigasi jika dibutuhkan
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card untuk itinerary "Shibuya"
            GestureDetector(
              onTap: () {
                // Navigasi ke itinerary_schedule.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItinerarySchedulePage()),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Gambar Shibuya
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.asset(
                        'assets/Shibuya.png', // Ganti sesuai dengan nama gambar Anda
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Detail informasi
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shibuya',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '16 Juni - 17 Juni 2024',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          Icon(Icons.edit, color: Colors.blue),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            // Tombol "Buat Itinerary baru"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke generate_itinerary.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TravelPlannerPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'Buat Itinerary baru',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
