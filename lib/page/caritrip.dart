// import 'package:flutter/material.dart';
// import 'package:travel_savy/page/home_screen.dart';
// import 'package:travel_savy/page/profile_dashboard.dart';
// import 'package:travel_savy/page/rekamperjalanan.dart';
// import 'bottom_nav.dart'; 

// class CariTrip extends StatefulWidget {
//   const CariTrip({super.key});

//   @override
//   _CariTripState createState() => _CariTripState();
// }

// class _CariTripState extends State<CariTrip> {
//   int selectedIndex = 2; // Index for the CariTrip page

//   void onTap(int index) {
//     setState(() {
//       selectedIndex = index; // Update the selected index
//     });

//     // Navigate based on the selected index
//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen()),
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => DashboardScreen()),
//         );
//         break;
//       case 2:
//         // Stay on the current page
//         break;
//       case 3:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => ProfileDashboard()),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Tulis Ceritamu',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 13,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 100),
//             Center(
//               child: Column(
//                 children: [
//                   Text(
//                     'Halaman ini belum siap dikoding!',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Image.asset(
//                     'assets/images/oswald.jpeg',
//                     height: 202,
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigation(
//         selectedIndex: selectedIndex,
//         onTap: onTap,
//       ),
//     );
//   }
// }
