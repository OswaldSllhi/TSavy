import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_savy/controllers/authentication.dart';
import 'package:travel_savy/page/auth/register.dart';
import 'package:travel_savy/page/home_screen.dart'; // Import HomeScreen

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthenticationController _authenticationController =
        Get.put(AuthenticationController());

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF277BC0),
              Color(0xFF071952),
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
                      // Input username
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Input password
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Remember me and login button
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (value) {}),
                          const Text("Remember me?"),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              // Panggil fungsi login saat tombol ditekan
                              await _authenticationController.login(
                                username: _usernameController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                              
                              // Pastikan navigasi terjadi setelah login sukses
                              if (_authenticationController.token.isNotEmpty) {
                                // Jika token berhasil disimpan, arahkan ke HomeScreen
                                Get.offAll(() => HomeScreen());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: Obx(() {
                              return _authenticationController.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text('Log in');
                            }),
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
                          // Navigasi ke halaman registrasi
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistPage(),
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
