import 'package:feather_icons/feather_icons.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_savy/controllers/CityController.dart';
import 'package:travel_savy/models/place_model.dart';
import 'package:travel_savy/models/type_model.dart';
import 'package:travel_savy/page/bottom_nav.dart';
import 'package:travel_savy/page/favorittempat.dart';
import 'profile_dashboard.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CityController cityController = Get.put(CityController());

  @override
  void initState() {
    super.initState();
    cityController.fetchCities();  // Memuat data kota saat halaman pertama kali dibuka
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 0,
        onTap: (index) => _onMenuTap(context, index),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _greetings(context),
              const SizedBox(height: 16),
              _card(),
              const SizedBox(height: 20),
              _search(),
              // const SizedBox(height: 20),
              // _types(),
              const SizedBox(height: 20),
              buildPlaceList(),  // Daftar tempat akan ditampilkan di sini
            ],
          ),
        ),
      ),
    );
  }

  void _onMenuTap(BuildContext context, int index) {
    if (index == 3) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ProfileDashboard(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(position: animation.drive(tween), child: child);
          },
        ),
      );
    }
  }

  Widget buildPlaceList() {
    return Obx(() {
      if (cityController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (cityController.cities.isEmpty) {
        return const Center(child: Text("Tidak ada data kota yang tersedia."));
      }

      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final city = cityController.cities[index];
          return _cityCard(
            cityName: city['city_name'] ?? 'Nama tidak tersedia',
            description: city['description'] ?? 'Deskripsi tidak tersedia',
            imagePath: city['imagePath'],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 11),
        itemCount: cityController.cities.length,
      );
    });
  }

  Container _cityCard({
    required String cityName,
    required String description,
    required String imagePath,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 195, 199, 247).withOpacity(.12),
            blurRadius: 30,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              imagePath,
              width: 88,
              height: 103,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported,
                  size: 88,
                  color: Colors.grey,
                );
              },
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cityName,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3F3E3F),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "Lihat lebih detail",
                      style: GoogleFonts.lato(
                        color: const Color(0xFF50CC98),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // SizedBox _types() {
  //   return SizedBox(
  //     height: 28,
  //     child: ListView.separated(
  //         padding: const EdgeInsets.symmetric(horizontal: 20),
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: (context, index) => Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 10),
  //               decoration: BoxDecoration(
  //                   color: selectedType == index
  //                       ? const Color(0xFF277BC0)
  //                       : const Color(0xFFF6F6F6),
  //                   border: selectedType == index
  //                       ? Border.all(
  //                           color: const Color(0xFFF1E5E5).withOpacity(.22),
  //                           width: 2)
  //                       : null,
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: Center(
  //                   child: Text(
  //                 Type.all()[index],
  //                 style: GoogleFonts.lato(
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.bold,
  //                     color: selectedType == index
  //                         ? Colors.white
  //                         : const Color(0xFF3F3E3F).withOpacity(.3)),
  //               )),
  //             ),
  //         separatorBuilder: (context, index) => const SizedBox(
  //               width: 10,
  //             ),
  //         itemCount: Type.all().length),
  //   );
  // }

  Widget _search() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(14)),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(
              FeatherIcons.search,
              color: Color(0xFFADACAD),
            ),
            hintText: "Cari destinasi tujuanmu",
            hintStyle: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFCACACA),
                height: 150 / 100)),
      ),
    );
  }

  AspectRatio _card() {
    return AspectRatio(
      aspectRatio: 290 / 161,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color.fromARGB(0, 39, 123, 192),
        ),
        child: Stack(children: [
          Image.asset(
            'assets/images/pemandangan.png',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: "Buat ",
                        style: GoogleFonts.arsenal(
                            fontSize: 14,
                            color: const Color(0xFFDEE1FE),
                            height: 150 / 100),
                        children: const [
                      TextSpan(
                          text: "Nyaman ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                      TextSpan(text: "Perjalanan\nliburanmu "),
                      TextSpan(
                          text: "bersama \nTravel Savvy!",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ])),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      border: Border.all(
                          color: Colors.white.withOpacity(.12), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Mulai perjalananmu",
                    style: GoogleFonts.lato(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Padding _greetings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hello, Travellers!',
            style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF3F3E3F)),
          ),
          Stack(children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavPlace(),
                    ),
                  );
                },
                icon: const Icon(
                  FeatherIcons.star,
                  color: Color(0xFF277BC0),
                )),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    color: const Color(0xFFEF6497),
                    borderRadius: BorderRadius.circular(15 / 2)),
                child: Center(
                    child: Text(
                  "2",
                  style: GoogleFonts.mPlus1p(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800),
                )),
              ),
            )
          ])
        ],
      ),
    );
  }
}
