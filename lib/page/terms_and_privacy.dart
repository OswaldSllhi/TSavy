import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   void onTermsTap() {
//     // Tindakan ketika tombol Term and Privacy diklik
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const TermsAndPrivacyPage(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard Profile'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: onTermsTap,
//               child: const Text('Term and Privacy'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class TermsAndPrivacyPage extends StatelessWidget {
  const TermsAndPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.of(context).pop(); // Balik ke halaman sebelumnya
              },
            ),
            const Text(
              'Term and Privacy',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   padding: EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //   color: Colors.white,
            //   // borderRadius: BorderRadius.circular(10),
            // ),
            // ),
          ],

        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),
            const Text(
              'TERM OF SERVICES',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20), // jarak
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 30),
            const Text(
              'Tentang Aplikasi',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20), // jarak
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
