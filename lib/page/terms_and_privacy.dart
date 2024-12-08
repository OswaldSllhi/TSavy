import 'package:flutter/material.dart';

class TermsAndPrivacyPage extends StatefulWidget {
  const TermsAndPrivacyPage({super.key});

  @override
  State<TermsAndPrivacyPage> createState() => _TermsAndPrivacyPageState();
}

class _TermsAndPrivacyPageState extends State<TermsAndPrivacyPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        centerTitle: true,
        // backgroundColor: Colors.white,
        title: const Text(
          'Term and Privacy',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.white,

        padding: const EdgeInsets.symmetric(horizontal: 24.0), //
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //
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

