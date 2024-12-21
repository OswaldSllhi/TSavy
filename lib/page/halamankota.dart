import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_savy/page/itinerary_list.dart';
import 'package:travel_savy/page/itinerarypage.dart';
import 'package:travel_savy/page/rekamperjalanan.dart';
import 'package:travel_savy/controllers/CityController.dart';
import 'package:travel_savy/controllers/WisataController.dart';
import 'package:travel_savy/constants/constants.dart';

class HalamanKota extends StatelessWidget {
  final int cityId;
  final CityController cityController = Get.put(CityController());
  final WisataController wisataController = Get.put(WisataController());

  HalamanKota({Key? key, required this.cityId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter kota berdasarkan cityId
    final city = cityController.cities.firstWhere(
      (city) => city['id'] == cityId,
      orElse: () => null,
    );

    // Panggil fetchWisataByCityId untuk mendapatkan data wisata
    wisataController.fetchWisataByCityId(cityId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: city == null
          ? const Center(
              child: Text('Data kota tidak ditemukan!'),
            )
          : Obx(() {
              if (wisataController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header gambar dan nama kota
                    Stack(
                      children: [
                        Image.asset(
                          city['imagePath'],
                          height: 280,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                city['city_name'] ?? 'Nama Kota',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Tombol "Mulai Perjalananmu"
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItineraryPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: const Color(0xFF277BC0),
                            ),
                            icon: const Icon(
                              Icons.flight_takeoff,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Mulai Perjalananmu',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Tombol "Tulis Ceritamu"
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  color: Color(0xFF277BC0)), // Border warna utama
                            ),
                            icon: const Icon(
                              Icons.book,
                              color: Color(0xFF277BC0),
                            ),
                            label: const Text(
                              'Tulis Ceritamu',
                              style: TextStyle(
                                  color: Color(0xFF277BC0), fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Informasi perjalanan
                          Container(
                            height: 131,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0xFF277BC0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Informasi Perjalanan',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _iconInfo('Panduan'),
                                    _iconInfo('Hukum'),
                                    _iconInfo('Informasi'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Deskripsi kota
                          Text(
                            city['city_deskripsi'] ?? 'Deskripsi tidak tersedia',
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 10),
                          // Daftar wisata populer
                          const Text(
                            'Wisata Populer',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          wisataController.wisataList.isEmpty
                              ? const Center(
                                  child: Text('Tidak ada wisata ditemukan.'),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  itemCount: wisataController.wisataList.length,
                                  itemBuilder: (context, index) {
                                    final wisata =
                                        wisataController.wisataList[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Card(
                                        elevation: 2,
                                        child: ExpansionTile(
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              'assets/images/wisata/${wisata["id"]}.jpg',
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const Icon(
                                                Icons.broken_image,
                                                size: 50,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            wisata['name'] ?? 'Nama Wisata',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            wisata['description'] ??
                                                'Deskripsi wisata tidak tersedia',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0,
                                                      vertical: 8.0),
                                              child: Text(
                                                wisata['description'] ??
                                                    'Deskripsi lengkap tidak tersedia',
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Jam: ${wisata['open_time'] ?? ''} - ${wisata['close_time'] ?? ''}',
                                                  ),
                                                  Text(
                                                    'Harga: Rp.${wisata['price'] ?? 0}',
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
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
            }),
    );
  }

  Widget _iconInfo(String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          child: Image.asset(
            'assets/images/kiw.png',
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
