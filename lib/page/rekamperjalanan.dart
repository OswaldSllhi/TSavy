import 'package:flutter/material.dart';
import 'package:travel_savy/page/tulisceritamu.dart';
import 'bottom_nav.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Rekam Perjalanan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, String>> stories = List.generate(5, (index) => {
    "title": "Kota ",
    "destination": "Japan",
    "content":
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "image": "assets/images/cerita.png"
  });

  int _selectedIndex = 1; // Indeks untuk halaman rekam perjalanan

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Travellers'),
        automaticallyImplyLeading: false, // Menyembunyikan tombol kembali
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rekam Setiap Perjalananmu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                          // Navigate to Register Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TulisCerita(),
                            ),
                          );
                        },
              child: Text("Tulis Ceritamu"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  final story = stories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoryDetailScreen(story: story),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: Image.asset(
                          story["image"]!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        title: Text(story["title"]!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(story["content"]!),
                            Text('Tujuan: ${story["destination"]}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class StoryDetailScreen extends StatelessWidget {
  final Map<String, String> story;

  StoryDetailScreen({required this.story});

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure to delete this story?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog jika "No" dipilih
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup dialog
              Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              // Logika penghapusan dapat disesuaikan jika perlu
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story["title"]!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              story["image"]!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              story["title"]!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Tujuan: ${story["destination"]}'),
            SizedBox(height: 16),
            Text(
              story["content"]! * 3, // Menampilkan konten lebih panjang
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showDeleteConfirmationDialog(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Hapus Cerita ini ?"),
            ),
          ],
        ),
      ),
    );
  }
}
