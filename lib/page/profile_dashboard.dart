import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_savy/controllers/authentication.dart';
import 'package:travel_savy/page/home_screen.dart';
import 'terms_and_privacy.dart';
import 'package:travel_savy/page/versi.dart';
import 'package:get/get.dart';
import 'package:travel_savy/page/my_itinerary.dart';
import 'profile.dart';
import 'bottom_nav.dart';

class ProfileDashboard extends StatefulWidget {
  @override
  _ProfileDashboardState createState() => _ProfileDashboardState();
}

class _ProfileDashboardState extends State<ProfileDashboard> {
  String? userName;

  @override
  void initState() {
    super.initState();

    // Retrieve the user's name from GetStorage
    var userData = GetStorage().read('user');
    if (userData != null) {
      setState(() {
        userName = userData['name'];
      });
    } else {
      debugPrint("No user data found in GetStorage");
      userName = "User"; // Default name if no user data is found
    }
  }

  void onProfileTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );
  }

  void onItineraryTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyItinerary()),
    );
  }

  void onAppVersionTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VersionScreen()),
    );
  }

  void onTermsTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TermsAndPrivacyPage()),
    );
  }

  void onMenuTap(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(-1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
                position: animation.drive(tween), child: child);
          },
        ),
      );
    }
  }

  Future<void> onLogoutTap() async {
    await AuthenticationController().logout();
    // Redirect user to login page after logout
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      bottomNavigationBar: BottomNavigation(
        selectedIndex: 3,
        onTap: onMenuTap,
      ),
      body: Stack(
        children: [
          // Gambar kanan.png yang tetap di kanan layar
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/kanan.png',
              scale: 2.5,
            ),
          ),
          // Gambar di posisi kiri atas
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/kiri.png',
              width: 100, // Sesuaikan ukuran gambar
              height: 100, // Sesuaikan ukuran gambar
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(height: 60),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  'assets/images/profile_image.png',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Hi, ${userName ?? "User"}', // Display the user's name dynamically
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hai ${userName ?? "User"} Siap untuk petualangan baru hari ini?',
                            style: TextStyle(
                              fontFamily: 'Arsenal',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Kami siap menemani perjalananmu',
                            style: TextStyle(
                              fontFamily: 'Arsenal',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          "Profil",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          onProfileTap(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          'assets/images/my_itinerary.png',
                          width: 32,
                          height: 32,
                        ),
                        title: Text(
                          "My Itinerary",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: onItineraryTap,
                      ),
                      ListTile(
                        leading: Icon(Icons.privacy_tip),
                        title: Text(
                          "Term and Privacy",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          onTermsTap(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.info),
                        title: Text(
                          "Versi Aplikasi",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          onAppVersionTap();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.red),
                        title: Text(
                          "Logout",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.red, // Tambahkan warna merah untuk menunjukkan logout
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.red),
                        onTap: () async {
                          // Memanggil fungsi logout dari AuthenticationController
                          AuthenticationController authController = Get.put(AuthenticationController());
                          await authController.logout();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
