import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EnteringPage.dart';
import 'Home.dart';
// import 'test.dart';

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
      //home: UserList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
