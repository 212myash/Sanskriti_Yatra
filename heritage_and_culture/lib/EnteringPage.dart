import 'package:flutter/material.dart';
import 'ask_for_new_user_or_existing.dart';

class EnteringPage extends StatelessWidget {
  const EnteringPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            right: -40,
            child: Container(
              height: 230,
              decoration: const BoxDecoration(
                color: Color(0xFFD88A26), // Orange bottom section
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon/heritage.png', // Ensure this is in your assets folder
                  height: 280,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 10),
                const Text(
                  'DIVE INTO A NEW ERA',
                  style: TextStyle(
                    color: Color(0xFFD88A26),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'एक नए युग में प्रवेश करें',
                  style: TextStyle(
                    color: Color(0xFFD88A26),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const ask_for_new_user_or_existing(),
                        ),
                      );
                    },
                    child: const Text(
                      'Go Ahead',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
