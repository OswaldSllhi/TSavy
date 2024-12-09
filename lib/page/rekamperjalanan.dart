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
  final ceritacontroller ceritaController = Get.put(ceritacontroller()); // Inisialisasi CeritaController
  int _selectedIndex = 1; // Indeks untuk halaman rekam perjalanan

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
                // Navigate to TulisCerita Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  TulisCerita(),
                  ),
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
                          leading: story["image"] != null
                              ? Image.network(
                                  story["image"],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : Icon(Icons.image, size: 80),
                          title: Text(story["title"] ?? 'Tanpa Judul'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(story["content"] ?? 'Konten tidak tersedia'),
                              Text('Tujuan: ${story["destination"] ?? "Tidak disebutkan"}'),
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

  // Fungsi untuk menampilkan dialog konfirmasi penghapusan
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
          onPressed: () async {
            // Menutup dialog konfirmasi
            Navigator.of(context).pop(); 

            // Memanggil fungsi untuk menghapus cerita dan mengarahkan ke halaman rekam perjalanan
            bool isDeleted = await Get.find<ceritacontroller>().destroyCerita(story['id'], context);
            
            // Kembali ke halaman sebelumnya setelah cerita dihapus
            if (isDeleted) {
              Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
            }
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
        title: Text(story["title"] ?? 'Tanpa Judul'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            story["image"] != null
                ? Image.network(
                    story["image"],
                    width: double.infinity,
                    fit: BoxFit.cover,
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showDeleteConfirmationDialog(context); // Memanggil dialog konfirmasi
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

