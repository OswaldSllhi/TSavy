import 'package:flutter/material.dart';
import 'package:travel_savy/page/version_update.dart';

class VersionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        // backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Versi',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ListTile(
            title: Text(
              'Tentang',
              style: TextStyle(color: Colors.black),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Versi 2.8.2',
                  style: TextStyle(color: Colors.grey),
                ),
                Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
            onTap: () {
              // Navigasi ke halaman VersionUpdate
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VersionUpdate()),
              );
            },
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.shade300,
            height: 1,
          ),
        ],
      ),
    );
  }
}
