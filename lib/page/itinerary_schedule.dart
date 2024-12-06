import 'package:flutter/material.dart';
import 'package:travel_savy/page/itinerary_list.dart';

class ItinerarySchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: Text(
          'My Itinerary',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/Shibuya.png',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shibuya',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Japan',
                      style: TextStyle(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ItineraryCard(
                  day: 'Day 1',
                  activity: 'Bakery at Anderson Tokyu',
                  time: '8.30am',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItineraryPage(),
                      ),
                    );
                  },
                ),
                ItineraryCard(
                  day: 'Day 2',
                  activity: 'Visit Shibuya Crossing',
                  time: '10.00am',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItineraryPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItineraryCard extends StatelessWidget {
  final String day;
  final String activity;
  final String time;
  final VoidCallback onTap;
  final Color backgroundColor;

  const ItineraryCard({
    required this.day,
    required this.activity,
    required this.time,
    required this.onTap,
    this.backgroundColor = Colors.blue, // Default warna biru
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: backgroundColor, // Gunakan warna latar dari properti
      child: ListTile(
        title: Text(
          day,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Teks putih untuk kontras
          ),
        ),
        subtitle: Text(
          '$activity\n$time',
          style: TextStyle(
            color: Colors.white70, // Teks subtitle dengan transparansi
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.white, // Ikon putih untuk kontras
        ),
        onTap: onTap,
      ),
    );
  }
}
