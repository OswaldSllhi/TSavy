import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_savy/controllers/ceritacontroller.dart';
import 'package:travel_savy/page/tulis_cerita.dart';
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
  final ceritacontroller ceritaController = Get.put(ceritacontroller());
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    ceritaController.fetchCeritas(); // Fetch cerita dari API saat init
  }

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
        automaticallyImplyLeading: false,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TulisCerita()),
                );
              },
              child: Text("Tulis Ceritamu"),
            ),
            Expanded(
              child: Obx(() {
                if (ceritaController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (ceritaController.ceritas.isEmpty) {
                  return Center(child: Text('Tidak ada cerita tersedia.'));
                }

                return ListView.builder(
                  itemCount: ceritaController.ceritas.length,
                  itemBuilder: (context, index) {
                    final story = ceritaController.ceritas[index];
                    final city = story["city"];

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
                          leading: city != null && city["id"] != null
                              ? Image.asset(
                                  'assets/images/cities/${city["id"]}.png', // Ambil gambar berdasarkan city_id
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 80), // Default icon jika gambar tidak ditemukan
                                )
                              : Icon(Icons.image, size: 80),
                          title: Text(story["title"] ?? 'Tanpa Judul'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(story["content"] ?? 'Konten tidak tersedia'),
                              Text('Kota: ${city != null ? city["name"] : "Tidak disebutkan"}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
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
  final Map<String, dynamic> story;

  StoryDetailScreen({required this.story});

  @override
  Widget build(BuildContext context) {
    final city = story["city"];

    return Scaffold(
      appBar: AppBar(
        title: Text(story["title"] ?? 'Tanpa Judul'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            city != null && city["id"] != null
                ? Image.asset(
                    'assets/images/cities/${city["id"]}.png', // Gambar berdasarkan city_id
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 200), // Default jika gambar tidak ditemukan
                  )
                : Icon(Icons.image, size: 200),
            SizedBox(height: 16),
            Text(
              story["title"] ?? 'Tanpa Judul',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Tujuan: ${story["destination"] ?? "Tidak disebutkan"}'),
            SizedBox(height: 16),
            Text(
              story["content"] ?? 'Konten tidak tersedia',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
