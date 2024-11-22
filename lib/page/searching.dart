import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HalamanSearching(),
    );
  }
}

class HalamanSearching extends StatefulWidget {
  @override
  _HalamanSearchingState createState() => _HalamanSearchingState();
}

class _HalamanSearchingState extends State<HalamanSearching> {
  final List<Map<String, String>> destinations = [
    {
      'name': 'Tokyo',
      'description': 'Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text ',
      'image': 'assets/images/japan.png'
    },
    {
      'name': 'London',
      'description': 'Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text ',
      'image': 'assets/images/japan.png'
    },
    {
      'name': 'Berlin',
      'description': 'Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text ',
      'image': 'assets/images/japan.png'
    },
    {
      'name': 'Paris',
      'description': 'Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text ',
      'image': 'assets/images/japan.png'
    },
    {
      'name': 'Kuala lumpur',
      'description': 'Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text Paragraph of text ',
      'image': 'assets/images/japan.png'
    },
  ];

  List<Map<String, String>> filteredDestinations = [];
  String message = '';
  int? highlightedIndex;

  @override
  void initState() {
    super.initState();
    filteredDestinations = destinations;
  }

  void _filterDestinations(String query) {
    final results = destinations.where((destination) {
      return destination['name']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredDestinations = results;
      message = results.isEmpty ? 'Destinasi tidak ditemukan' : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: (value) => _filterDestinations(value),
                decoration: InputDecoration(
                  hintText: 'Cari destinasi tujuan anda',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            if (message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDestinations.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        highlightedIndex = index;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: highlightedIndex == index ? Colors.blue : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [

                            Container(
                              width: 100,
                              height: 100,
                              child: Image.asset(
                                filteredDestinations[index]['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filteredDestinations[index]['name']!,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(filteredDestinations[index]['description']!),
                                  ],
                                ),
                              ),
                            ),
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
