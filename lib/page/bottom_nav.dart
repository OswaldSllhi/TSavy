import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:travel_savy/page/itinerarypage.dart';
import 'package:travel_savy/page/home_screen.dart';
import 'package:travel_savy/page/profile_dashboard.dart';
import 'rekamperjalanan.dart';

var menus = [
  FeatherIcons.home,
  FeatherIcons.book,
  FeatherIcons.briefcase,
  FeatherIcons.user
];

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  BottomNavigation({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        onTap(index);
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ItineraryPage()),
          );
        } else if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileDashboard()),
          );
        }
        // Tambahkan navigasi ke halaman lainnya jika diperlukan
      },
      selectedItemColor: const Color(0xFF277BC0),
      type: BottomNavigationBarType.fixed,
      items: menus
          .map((e) =>
              BottomNavigationBarItem(icon: Icon(e), label: e.toString()))
          .toList(),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: const Color(0xFFBFBFBF),
    );
  }
}
