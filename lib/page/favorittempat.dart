import 'package:flutter/material.dart';

class FavPlace extends StatefulWidget {
  @override
  _FavPlaceState createState() => _FavPlaceState();
}

class _FavPlaceState extends State<FavPlace> {
  final List<Map<String, String>> cities = List.generate(5, (index) => {
    "title": "Kota Japan",
    "content":
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "image": "assets/images/cerita.png"
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Travellers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Destinasi Pilihan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityDetailScreen(city: city),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: Image.asset(
                          city["image"]!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        title: Text(city["title"]!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Deskripsi: '),
                            Text(city["content"]!),

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
    );
  }
}

class CityDetailScreen extends StatelessWidget {
  final Map<String, String> city;

  CityDetailScreen({Key? key, required this.city}) : super(key: key);
  //cityDetailScreen({required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city["title"]!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              city["image"]!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            // Text(
            //   city["title"]!,
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 8),
            // Text('Deskripsi: '),
            SizedBox(height: 16),
            Text(
              city["content"]! * 3, // Menampilkan konten lebih panjang
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
