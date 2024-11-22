import 'package:flutter/material.dart';

class RegistPage extends StatelessWidget {
  const RegistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF277BC0), // Warna pertama (277BC0)
              Color(0xFF071952), // Warna kedua (071952)
            ],
          ),
        ),
        child: Stack(
          children: [
            // // Bulat atas di kiri atas
            // Positioned(
            //   top: 0,
            //   left: -13,
            //   child: SizedBox(
            //     width: 175,
            //     height: 175,
            //     child: Image.asset('assets/images/bulatatas.png'),
            //   ),
            // ),

            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
                height: 636,
                width: 324,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Travel Savy',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),

                      const Text(
                        'Sign Up is Easier',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Social Media Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/images/fb.png',
                              height: 40,
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/images/gooogle.png',
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Divider with text
                      const Row(
                        children: <Widget>[
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 0.5,
                              endIndent: 10,
                            ),
                          ),
                          Text(
                            'or',
                            style: TextStyle(color: Colors.black),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 0.5,
                              indent: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Email or Phone number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Fullname',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Remember Me and Login Button
                      Center(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                
                                backgroundColor: Colors
                                    .blue, // Ubah warna tombol menjadi biru
                              ),
                              child: const Text('Register'),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
