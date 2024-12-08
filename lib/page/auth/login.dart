import 'package:flutter/material.dart';
import 'package:travel_savy/page/auth/register.dart';
import 'package:travel_savy/page/home_screen.dart'; // Pastikan RegistPage diimpor

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
            // Bulat atas di kiri atas
            Positioned(
              top: 0,
              left: -13,
              child: SizedBox(
                width: 175,
                height: 175,
                child: Image.asset('assets/images/bulatatas.png'),
              ),
            ),

            // Logo di tengah atas
            Align(
              alignment: const Alignment(0, -0.75),
              child: Image.asset(
                'assets/images/logo.png',
                width: 190,
                height: 190,
              ),
            ),

            // Form di bawah logo dengan border radius
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
                height: 454,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Email or Phone number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Remember Me and Login Button
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (value) {}),
                          const Text("Remember me?"),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to HomeScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.blue, // Ubah warna tombol menjadi biru
                            ),
                            child: const Text('Log in'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Divider with text
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Divider(
                              color: Colors.grey[300],
                              thickness: 0.5,
                              endIndent: 10,
                            ),
                          ),
                          const Text(
                            'or log in/register with',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 0.5,
                              indent: 10,
                            ),
                          ),
                        ],
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

                      // Register Text
                      TextButton(
                        onPressed: () {
                          // Navigate to Register Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  RegistPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Don't have an account? Register now!",
                          style: TextStyle(
                            color: Colors.blue[300],
                          ),
                        ),
                      ),
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
