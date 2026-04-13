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

  static double _appTextScale(double width) {
    if (width < 330) return 0.86;
    if (width < 380) return 0.92;
    if (width < 450) return 1.0;
    if (width < 800) return 1.05;
    return 1.12;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanskriti Yatra',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(211, 221, 229, 1),
      ),
      builder: (context, child) {
        final media = MediaQuery.of(context);
        final scale = _appTextScale(media.size.width);

        return MediaQuery(
          data: media.copyWith(textScaler: TextScaler.linear(scale)),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: isLoggedIn ? const HomePage() : const EnteringPage(),
      //home: UserList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
