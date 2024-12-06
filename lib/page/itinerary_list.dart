import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Itinerary Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ItineraryPage(),
    );
  }
}

class ItineraryPage extends StatefulWidget {
  @override
  _ItineraryPageState createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  final List<ItineraryItem> editableItineraryItems = List.from(itineraryItems);

  // Generate controllers for each item
  final List<TextEditingController> timeControllers = [];
  final List<TextEditingController> activityControllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize TextEditingControllers for each item
    for (var item in editableItineraryItems) {
      timeControllers.add(TextEditingController(text: item.time));
      activityControllers.add(TextEditingController(text: item.activity));
    }
  }

  void _showModalNotification(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            "Success",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "Perubahan berhasil disimpan.",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close modal
              },
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveChanges() {
    setState(() {
      // Update data in editableItineraryItems
      for (int i = 0; i < editableItineraryItems.length; i++) {
        editableItineraryItems[i].time = timeControllers[i].text;
        editableItineraryItems[i].activity = activityControllers[i].text;
      }
    });
    _showModalNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Itinerary List"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigasi kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Column(
        children: [
          // Header
          Stack(
            children: [
              Image.asset(
                'assets/Shibuya.png', // Ganti dengan gambar header Anda
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.black.withOpacity(0.3),
              ),
              Positioned(
                bottom: 50,
                left: 16,
                child: Text(
                  'Shibuya',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 16,
                child: Text(
                  '16 Juni',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          // Content
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount:
                  editableItineraryItems.length + 2, // +2 for space and button
              itemBuilder: (context, index) {
                if (index == editableItineraryItems.length + 1) {
                  // Simpan Button
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 24.0), // Tambahkan jarak lebih jauh
                    child: Center(
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          'Simpan',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                } else if (index == editableItineraryItems.length) {
                  return SizedBox(
                      height: 16); // Spacer tambahan antara list dan tombol
                }
                final item = editableItineraryItems[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      // Editable Time
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: timeControllers[index],
                          onChanged: (value) {
                            item.time = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 8),
                      // Editable Activity
                      Flexible(
                        flex: 2,
                        child: TextField(
                          controller: activityControllers[index],
                          onChanged: (value) {
                            item.activity = value;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose all controllers to avoid memory leaks
    for (var controller in timeControllers) {
      controller.dispose();
    }
    for (var controller in activityControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

// Model data untuk item itinerary
class ItineraryItem {
  String time;
  String activity;

  ItineraryItem(this.time, this.activity);
}

// Data dummy itinerary
final itineraryItems = [
  ItineraryItem("8:30AM - 9:30AM", "Bakery at Andersen Tokyo Food"),
  ItineraryItem("9:30AM - 10:30AM", "Bus to Ebisu Garden Place"),
  ItineraryItem("10:30AM - 11:00AM", "Explore Ebisu Garden"),
  ItineraryItem("11:00AM - 12:00PM", "Brunch at Omotesando"),
  ItineraryItem("12:00PM - 1:00PM", "Walk to Official Street Go-Kart"),
];
