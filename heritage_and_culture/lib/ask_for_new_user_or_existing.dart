// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ask_for_new_user_or_existing(),
    );
  }
}

class ask_for_new_user_or_existing extends StatelessWidget {
  const ask_for_new_user_or_existing({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.34;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFD88A26), // Orange corner
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                ),
              ),
              child: const Text(
                "DISCOVER\nTHE SPORT",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.28,
              decoration: const BoxDecoration(
                color: Color(0xFFD88A26), // Orange bottom section
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 18,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFD88A26),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(42),
                        ),
                      ),
                      child: const Text(
                        "DISCOVER\nTHE SPORT",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  Image.asset(
                    'assets/icon/heritage.png',
                    height: imageHeight,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading image: $error');
                      return const Icon(Icons.error,
                          size: 100, color: Colors.red);
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'DIVE INTO A NEW ERA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFD88A26),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'एक नए युग में प्रवेश करें',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFD88A26),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(flex: 1),
                  SizedBox(
                    width: 240,
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint('Navigating to LoginPage...');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      child: const Text('Sign In'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 240,
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint('Navigating to SignUpPage...');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      child: const Text('Signup'),
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
