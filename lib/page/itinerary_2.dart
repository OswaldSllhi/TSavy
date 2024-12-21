import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_savy/page/itinerary_list.dart';
import 'package:travel_savy/controllers/CityController.dart';
import 'package:travel_savy/controllers/CategoryController.dart';
import 'package:travel_savy/controllers/itinerary_controller.dart';

class TravelPlannerPage extends StatefulWidget {
  @override
  _TravelPlannerPageState createState() => _TravelPlannerPageState();
}

class _TravelPlannerPageState extends State<TravelPlannerPage> {
  String? selectedCity;
  List<int> selectedCategories = [];
  String? selectedMinBudget;
  String? selectedMaxBudget;
  DateTime? departureDate;
  DateTime? returnDate;

  final cityController = Get.put(CityController());
  final categoryController = Get.put(CategoryController());
  final itineraryController = Get.put(ItineraryController());

  @override
  void initState() {
    super.initState();
    cityController.fetchCities();
    categoryController.fetchCategories();
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          departureDate = picked;
        } else {
          returnDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Planner'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown kota
            Obx(() {
              if (cityController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return DropdownButtonFormField<String>(
                value: selectedCity,
                items: cityController.cities.map((city) {
                  return DropdownMenuItem(
                    value: city['id'].toString(),
                    child: Text(city['city_name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select City',
                  border: OutlineInputBorder(),
                ),
              );
            }),

            const SizedBox(height: 16.0),

            // Checkbox kategori
Obx(() {
  if (categoryController.isLoading.value) {
    return const Center(child: CircularProgressIndicator());
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Aktivitas yang anda sukai',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
      const SizedBox(height: 8.0),
      Wrap(
        spacing: 30.0, // Jarak horizontal antar elemen
        runSpacing: 10.0, // Jarak vertikal antar elemen
        children: categoryController.categories.map((category) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: selectedCategories.contains(category['id']),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedCategories.add(category['id']);
                    } else {
                      selectedCategories.remove(category['id']);
                    }
                  });
                },
                activeColor: Colors.blue, // Warna checkbox
              ),
              Text(category['name']),
            ],
          );
        }).toList(),
      ),
    ],
  );
}),


            const SizedBox(height: 16.0),

            // Budget
            TextField(
              decoration: const InputDecoration(
                labelText: 'Minimum Budget',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                selectedMinBudget = value;
              },
            ),

            const SizedBox(height: 16.0),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Maximum Budget',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                selectedMaxBudget = value;
              },
            ),

            const SizedBox(height: 16.0),

            // Tanggal keberangkatan dan kembali
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Departure Date',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                          text: departureDate != null
                              ? '${departureDate!.toLocal()}'.split(' ')[0]
                              : '',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, false),
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Return Date',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                          text: returnDate != null
                              ? '${returnDate!.toLocal()}'.split(' ')[0]
                              : '',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Tombol Generate
            Center(
              child: ElevatedButton(
              onPressed: () async {
                if (selectedCity == null ||
                    selectedCategories.isEmpty ||
                    selectedMinBudget == null ||
                    selectedMaxBudget == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields.')),
                  );
                  return;
                }

                final minBudget = int.tryParse(selectedMinBudget!);
                final maxBudget = int.tryParse(selectedMaxBudget!);

                if (minBudget == null || maxBudget == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter valid budgets.')),
                  );
                  return;
                }

                // try {
                //   await itineraryController.generateItinerary(
                //     cityId: int.parse(selectedCity!),
                //     categories: selectedCategories,
                //     days: returnDate != null && departureDate != null
                //         ? returnDate!.difference(departureDate!).inDays
                //         : 1,
                //     price: (minBudget + maxBudget) ~/ 2,
                //   );

                //   Get.to(() => ItineraryPage());
                // } catch (e) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text('Failed to generate itinerary: $e')),
                //   );
                // }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('GENERATE'),
            ),
            )
          ],
        ),
      ),
    );
  }
}

class ItineraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itinerary'),
      ),
      body: const Center(
        child: Text('Itinerary Page Content'),
      ),
    );
  }
}
