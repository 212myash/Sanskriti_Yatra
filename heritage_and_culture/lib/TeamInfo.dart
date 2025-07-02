// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EnteringPage.dart';
import 'Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanskriti Yatra',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(211, 221, 229, 1),
      ),
      home: isLoggedIn ? const HomePage() : const EnteringPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TeamPage extends StatelessWidget {
  final List<Map<String, String>> teamMembers = [
    {
      "name": "M. YASH RAJ",
      "position": "DEVELOPER",
      "occuption": """
Student of LPU
(Lovely Professional University)
""",
      "image": "assets/team/Yash.jpg",
    },
    {
      "name": "SAUMYA MIHIR",
      "position": "DEVELOPER",
      "occuption": """
Student of LPU
(Lovely Professional University)
""",
      "image": "assets/team/Mihir.jpg",
    },
    {
      "name": "ANUSHKA RANJAN",
      "position": "DEVELOPER",
      "occuption": """
Student of LPU
(Lovely Professional University)
""",
      "image": "assets/team/Anu.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5A623), // Set AppBar color
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Our Team",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: teamMembers.length,
          itemBuilder: (context, index) {
            final member = teamMembers[index];
            return Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    member["image"]!,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member["name"]!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      member["position"]!,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 107, 110, 112),
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      member["occuption"]!,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.grey, // Set the color of the divider
              thickness: 1, // Set the thickness of the divider
              height: 20, // Add spacing around the divider
            );
          },
        ),
      ),
    );
  }
}
