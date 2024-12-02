import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TravelPlannerPage(),
    );
  }
}

class TravelPlannerPage extends StatefulWidget {
  @override
  _TravelPlannerPageState createState() => _TravelPlannerPageState();
}

class _TravelPlannerPageState extends State<TravelPlannerPage> {
  final Color sectionTitleColor = Color(0xFF277BC0);

  String? selectedCountry;
  String? selectedCity;
  String? selectedMinBudget;
  String? selectedMaxBudget;
  String? selectedAccommodation;

  List<String> countries = ['Indonesia', 'Jepang', 'Inggris'];

  Map<String, List<String>> cities = {
    'Indonesia': ['Jakarta', 'Bali', 'Yogyakarta', 'Bandung', 'Surabaya'],
    'Jepang': ['Tokyo', 'Kyoto', 'Osaka', 'Hokkaido', 'Fukuoka'],
    'Inggris': ['London', 'Manchester', 'Liverpool', 'Edinburgh', 'Bristol'],
  };

  Map<String, bool> travelTypes = {
    'Santai': false,
    'Bisnis': false,
    'Study tour': false,
  };

  Map<String, bool> activities = {
    'Pantai': false,
    'Relaxing': false,
    'Olahraga': false,
    'Gunung': false,
    'Membaca': false,
    'Party': false,
    'Camping': false,
    'Pameran': false,
    'Perkotaan': false,
    'Petualangan': false,
    'Sightseeing': false,
    'Culinary': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[800],
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60.0),
                    child: Center(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Atur Kenyamanan\nPerjalananmu',
                            style: TextStyle(
                              fontFamily: 'Arsenal',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 28.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '#BersamaTravelSavy',
                            style: TextStyle(
                              fontFamily: 'Arsenal',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Image.asset(
                    'assets/image/lingkaran.png',
                    height: 100.0,
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdownSection('Kemana tujuan anda?', [
              _buildDropdown(
                hint: 'Negara',
                value: selectedCountry,
                items: countries,
                onChanged: (value) {
                  setState(() {
                    selectedCountry = value;
                    selectedCity = null;
                  });
                },
              ),
              SizedBox(height: 10),
              _buildDropdown(
                hint: 'Kota',
                value: selectedCity,
                items: selectedCountry != null ? cities[selectedCountry]! : [],
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
              ),
            ]),
            SizedBox(height: 20),
            _buildCheckboxSection(
              'Cocok untuk jenis perjalanan apa?',
              travelTypes,
            ),
            SizedBox(height: 20),
            _buildCheckboxSection(
              'Aktivitas yang anda sukai',
              activities,
            ),
            SizedBox(height: 20),
            _buildDropdownSection('Budget Perjalanan', [
              _buildDropdown(
                hint: 'Minimal',
                value: selectedMinBudget,
                items: ['100-500k', '500k-1jt', '1-5jt', '10jt'],
                onChanged: (value) {
                  setState(() {
                    selectedMinBudget = value;
                  });
                },
              ),
              SizedBox(height: 10),
              _buildDropdown(
                hint: 'Maksimal',
                value: selectedMaxBudget,
                items: ['10jt', '20jt', '30jt', '40jt'],
                onChanged: (value) {
                  setState(() {
                    selectedMaxBudget = value;
                  });
                },
              ),
            ]),
            SizedBox(height: 20),
            _buildDropdownSection('Jenis Akomodasi', [
              _buildDropdown(
                hint: 'Transportasi',
                value: selectedAccommodation,
                items: ['Mobil', 'Bus', 'Pesawat'],
                onChanged: (value) {
                  setState(() {
                    selectedAccommodation = value;
                  });
                },
              ),
            ]),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('Generate data perjalanan...');
                },
                child: Text(
                  'GENERATE',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Color(0xFF277BC0), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      hint: Text(hint),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildCheckboxSection(String title, Map<String, bool> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: sectionTitleColor,
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 15.0,
          runSpacing: 10.0,
          children: options.keys.map((key) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: options[key],
                  onChanged: (bool? value) {
                    setState(() {
                      options[key] = value!;
                    });
                  },
                  fillColor: MaterialStateProperty.all(
                    Color.fromRGBO(39, 123, 192, 0.47),
                  ),
                  side: BorderSide.none,
                ),
                Text(
                  key,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDropdownSection(String title, List<Widget> widgets) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: sectionTitleColor,
          ),
        ),
        SizedBox(height: 10),
        ...widgets,
      ],
    );
  }
}
