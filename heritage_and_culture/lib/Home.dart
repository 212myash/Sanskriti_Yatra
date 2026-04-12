// ignore_for_file: file_names, unused_field
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testapp/HomeImageDetailPage.dart';
import 'package:testapp/about_page.dart';
import 'DashboardPage.dart';
import 'AddDestinationsPage.dart';
import 'NotificationsPage.dart';
import 'SearchPageState.dart';
import 'TeamInfo.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sanskriti Yatra',
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class User {
  final String image;
  final String name;
  final String state;
  final String description;

  User({
    required this.image,
    required this.name,
    required this.state,
    required this.description,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      image: json['image'],
      name: json['name'],
      state: json['state'],
      description: json['description'],
    );
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _currentIndex = 0;

  final List<String> _imagePaths = [
    'assets/home_image/Agra_Fort.jpg',
    'assets/home_image/Ayodhya.jpeg',
    'assets/home_image/golden_temple.jpg',
    'assets/home_image/hawa_mahal.jpg',
    'assets/home_image/Kedarnath.jpg',
    'assets/home_image/mahabodhi.jpg',
    'assets/home_image/hampi.jpeg',
  ];

  final List<Widget> _pages = [
    const DashboardPage(),
    const SearchPage(),
  ];

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex == 0) {
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        SystemNavigator.pop();
      }
    } else {
      setState(() {
        _selectedIndex = 0;
      });
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFFF5A623),
          title: const Text(
            'Sanskriti Yatra',
            style: TextStyle(color: Colors.white),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              tooltip: "Menu",
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                tooltip: "Notifications",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsPage()),
                  );
                },
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFFF5A623),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home_work_outlined),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.search_outlined),
                title: const Text('Search'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_location),
                title: const Text('Add Destinations'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddDestinationPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: _logout,
              ),
              ListTile(
                leading: const Icon(Icons.person_4_outlined),
                title: const Text('Team'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeamPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            if (_selectedIndex == 0)
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  height: 280.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: _imagePaths.asMap().entries.map((entry) {
                  int index = entry.key;
                  String path = entry.value;

                  List<Map<String, String>> imageDetails = [
                    {
                      "title": "Agra Fort",
                      "statename": "Uttar Pradesh",
                      "description":
                          "Agra Fort is a fort in the city of Agra in the Indian state of Uttar Pradesh.",
                    },
                    {
                      "title": "Ayodhya",
                      "statename": "Uttar Pradesh",
                      "description":
                          "Ayodhya, located in Uttar Pradesh, India, is an ancient city steeped in religious and historical significance. It is believed to be the birthplace of Lord Rama, central to the Hindu epic *Ramayana*. A major pilgrimage destination, it houses the Ram Janmabhoomi, a site of deep religious importance. Ayodhya also features prominent temples like Hanuman Garhi and Kanak Bhawan. The city has been a focal point for political and religious debates, especially concerning the Babri Masjid. In recent years, Ayodhya has seen significant development, particularly with the ongoing construction of the Ram Mandir, attracting both spiritual and tourism interest."
                    },
                    {
                      "title": "Golden Temple",
                      "statename": "Punjab",
                      "description":
                          "The holiest site of Sikhism in Amritsar.The Golden Temple, also known as Harmandir Sahib, is a revered Sikh gurdwara located in Amritsar, Punjab, India. It was founded by Guru Ram Das in 1581 and later completed by his successor, Guru Arjan Dev. The temple is renowned for its stunning architecture, with its central structure covered in gold leaf, giving it the iconic name. Surrounded by a large pool, the Golden Temple symbolizes unity and inclusivity. It is a place of worship, peace, and reflection, attracting millions of pilgrims annually. The gurdwara also serves free meals to thousands through its Langar service."
                    },
                    {
                      "title": "Hawa Mahal",
                      "statename": "Rajasthan",
                      "description":
                          "Famous palace in Jaipur, Rajasthan.Hawa Mahal, also known as the (Palace of Winds,) is a stunning architectural marvel located in Jaipur, Rajasthan, India. Built in 1799 by Maharaja Sawai Pratap Singh, it was designed by architect Lal Chand Ustad. The palace features a unique five-story structure with 953 small windows (jharokhas) decorated with intricate latticework, allowing cool breezes to flow through, keeping the palace comfortable in the hot desert climate. The Hawa Mahal was originally built for the royal women to observe street festivals without being seen. Its pink sandstone facade and delicate design make it a popular tourist attraction."
                    },
                    {
                      "title": "Kedarnath",
                      "statename": "Uttarakhand",
                      "description":
                          "One of the twelve Jyotirlingas of Lord Shiva.Kedarnath, located in the Garhwal Himalayas of Uttarakhand, India, is one of the holiest pilgrimage sites in Hinduism. Dedicated to Lord Shiva, it is part of the Char Dham Yatra and is situated at an altitude of 3,583 meters. The Kedarnath Temple, built in ancient times, is renowned for its stunning stone architecture and spiritual significance. The region is surrounded by breathtaking snow-capped peaks and scenic landscapes. Accessible via a challenging trek or helicopter services, Kedarnath attracts devotees and trekkers alike, offering both spiritual solace and natural beauty. The temple is open for worship from May to November."
                    },
                    {
                      "title": "Mahabodhi Temple",
                      "statename": "Bihar",
                      "description":
                          "The place where Buddha attained enlightenment.The Mahabodhi Temple, a UNESCO World Heritage Site in Bodh Gaya, Bihar, is one of Buddhism’s most sacred sites. Built in the 5th–6th century CE, it marks the spot where Siddhartha Gautama attained enlightenment under the Bodhi Tree. The temple, with its iconic pyramidal tower rising 55 meters, showcases exquisite carvings and inscriptions. It houses a grand Buddha statue in the meditation posture. The Bodhi Tree and the Vajrasana (Diamond Throne) add to its spiritual significance. A revered pilgrimage destination, the temple attracts devotees worldwide, reflecting India's rich architectural and religious heritage."
                    },
                    {
                      "title": "Hampi",
                      "statename": "Karnataka",
                      "description":
                          "A historic city in Karnataka, known for its ruins.Hampi, a UNESCO World Heritage Site in Karnataka, was the capital of the Vijayanagara Empire in the 14th–16th centuries. Known for its stunning ruins, it features grand temples, royal enclosures, stone chariots, and intricate sculptures. The Virupaksha Temple, Vittala Temple with its iconic musical pillars, and the Elephant Stables highlight its architectural brilliance. Surrounded by rocky landscapes and the Tungabhadra River, Hampi was a thriving trade and cultural hub. Today, it attracts history enthusiasts and spiritual seekers, offering a glimpse into India’s glorious past. Its vibrant heritage, ancient markets, and unique boulder-strewn terrain make it a must-visit destination."
                    },
                  ];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeImageDetailPage(
                            imagePath: path,
                            title: imageDetails[index]["title"]!,
                            statename: imageDetails[index]["statename"]!,
                            description: imageDetails[index]["description"]!,
                          ),
                        ),
                      );
                    },
                    child: Image.asset(path,
                        fit: BoxFit.cover, width: double.infinity),
                  );
                }).toList(),
              ),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: _pages,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black54,
          backgroundColor: const Color(0xFFF5A623),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ],
        ),
      ),
    );
  }
}
