// import 'package:flutter/material.dart';
// import 'package:travel_savy/page/terms_and_privacy.dart';
// // import 'terms_and_privacy_page.dart'; // Pastikan file ini ada dan berfungsi
// import 'profile.dart'; // Pastikan file ini ada dan berfungsi

// class ProfileDashboard extends StatefulWidget {
//   @override
//   _ProfileDashboardState createState() => _ProfileDashboardState();
// }

// class _ProfileDashboardState extends State<ProfileDashboard> {
//   void onProfileTap(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => EditProfilePage()),
//     );
//   }

//   void onLanguageTap() {
//     print("Bahasa diklik");
//   }

//   void onAppVersionTap() {
//     print("Versi Aplikasi diklik");
//   }

//   void onTermsTap(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => TermsAndPrivacyPage()),
//     );
//   }

//   void onPolicyTap() {
//     print("Policy diklik");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[800],
//       body: Stack(
//         children: [
//           // Gambar kanan.png yang tetap di kanan layar
//           Positioned(
//             top: 0,
//             right: 0,
//             child: Image.asset(
//               'assets/kanan.png',
//               scale: 2.5,
//               // height: MediaQuery.of(context).size.height,
//               //fit: BoxFit.fitHeight,
//             ),
//           ),
//           // Gambar di posisi kiri atas
//           Positioned(
//             top: 0,
//             left: 0,
//             child: Image.asset(
//               'assets/kiri.png',
//               width: 100, // Sesuaikan ukuran gambar
//               height: 100, // Sesuaikan ukuran gambar
//               fit: BoxFit.cover,
//             ),
//           ),
//           Column(
//             children: [
//               SizedBox(height: 60),
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: AssetImage(
//                   'assets/profile_image.png',
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'Hi, Oswald',
//                 style: TextStyle(
//                   fontFamily: 'Montserrat',
//                   color: Colors.white,
//                   fontSize: 40,
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20),
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Hai Oswald! Siap untuk petualangan baru hari ini?',
//                             style: TextStyle(
//                               fontFamily: 'Arsenal',
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Text(
//                             'Kami siap menemani perjalananmu',
//                             style: TextStyle(
//                               fontFamily: 'Arsenal',
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: ListView(
//                     children: [
//                       ListTile(
//                         leading: Icon(Icons.person),
//                         title: Text(
//                           "Profil",
//                           style: TextStyle(
//                             fontFamily: 'Montserrat',
//                           ),
//                         ),
//                         trailing: Icon(Icons.arrow_forward_ios),
//                         onTap: () {
//                           onProfileTap(context);
//                         },
//                       ),
//                       // ListTile(
//                       //   leading: Icon(Icons.language),
//                       //   title: Text(
//                       //     "Bahasa",
//                       //     style: TextStyle(
//                       //       fontFamily: 'Montserrat',
//                       //     ),
//                       //   ),
//                       //   trailing: Icon(Icons.arrow_forward_ios),
//                       //   onTap: onLanguageTap,
//                       // ),
//                       ListTile(
//                         leading: Icon(Icons.info),
//                         title: Text(
//                           "Versi Aplikasi",
//                           style: TextStyle(
//                             fontFamily: 'Montserrat',
//                           ),
//                         ),
//                         trailing: Icon(Icons.arrow_forward_ios),
//                         onTap: onAppVersionTap,
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.privacy_tip),
//                         title: Text(
//                           "Term and Privacy",
//                           style: TextStyle(
//                             fontFamily: 'Montserrat',
//                           ),
//                         ),
//                         trailing: Icon(Icons.arrow_forward_ios),
//                         onTap: () {
//                           onTermsTap(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
