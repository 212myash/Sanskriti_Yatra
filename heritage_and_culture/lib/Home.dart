// ignore_for_file: file_names, unused_field
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testapp/HomeImageDetailPage.dart';
import 'package:testapp/DestinationDetailPage.dart';
import 'package:testapp/about_page.dart';
import 'HeritageGalleryPage.dart';
import 'DashboardPage.dart';
import 'AllDestinationsPage.dart';
import 'StateCategoryPage.dart';
import 'HistoricalHeritagePage.dart';
import 'TraditionalArtsPage.dart';
import 'FestivalsPage.dart';
import 'DanceMusicPage.dart';
import 'LanguageLiteraturePage.dart';
import 'CulinaryHeritagePage.dart';
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
  final String category;
  final String description;

  User({
    required this.image,
    required this.name,
    required this.state,
    this.category = '',
    required this.description,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      image: json['image']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Name',
      state: json['state']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      description:
          json['description']?.toString() ?? 'No description available',
    );
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _currentIndex = 0;
  final TextEditingController _homeSearchController = TextEditingController();

  final List<String> _stateNames = const [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  final List<Map<String, String>> _quickDestinations = const [
    {
      'title': 'Taj Mahal',
      'state': 'Uttar Pradesh',
      'category': 'Culture',
      'image': 'assets/home_image/Agra_Fort.jpg',
      'description': 'Iconic marble mausoleum and one of the Seven Wonders.',
    },
    {
      'title': 'Agra Fort',
      'state': 'Uttar Pradesh',
      'category': 'History',
      'image': 'assets/home_image/Agra_Fort.jpg',
      'description':
          'Agra Fort is a fort in the city of Agra in the Indian state of Uttar Pradesh.',
    },
    {
      'title': 'Ayodhya',
      'state': 'Uttar Pradesh',
      'category': 'Culture',
      'image': 'assets/home_image/Ayodhya.jpeg',
      'description': 'Ancient city and major pilgrimage destination.',
    },
    {
      'title': 'Golden Temple',
      'state': 'Punjab',
      'category': 'Culture',
      'image': 'assets/home_image/golden_temple.jpg',
      'description': 'The holiest gurdwara of Sikhism in Amritsar.',
    },
    {
      'title': 'Hawa Mahal',
      'state': 'Rajasthan',
      'category': 'History',
      'image': 'assets/home_image/hawa_mahal.jpg',
      'description': 'Famous palace in Jaipur known as Palace of Winds.',
    },
    {
      'title': 'Kedarnath',
      'state': 'Uttarakhand',
      'category': 'Tourism',
      'image': 'assets/home_image/Kedarnath.jpg',
      'description':
          'One of the holiest pilgrimage sites dedicated to Lord Shiva.',
    },
    {
      'title': 'Mahabodhi Temple',
      'state': 'Bihar',
      'category': 'History',
      'image': 'assets/home_image/mahabodhi.jpg',
      'description': 'UNESCO site where Buddha attained enlightenment.',
    },
    {
      'title': 'Hampi',
      'state': 'Karnataka',
      'category': 'History',
      'image': 'assets/home_image/hampi.jpeg',
      'description': 'Historic ruins of the Vijayanagara empire.',
    },
  ];

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

  @override
  void dispose() {
    _homeSearchController.dispose();
    super.dispose();
  }

  String _normalize(String value) => value.toLowerCase().trim();

  List<String> _tokens(String text) {
    return text
        .split(RegExp(r'\s+'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  bool _containsAllTokens(String text, List<String> tokens) {
    for (final token in tokens) {
      if (!text.contains(token)) {
        return false;
      }
    }
    return true;
  }

  String _applySearchAliases(String query) {
    final aliases = <String, String>{
      'taj mahal': 'agra fort',
      'tajmahal': 'agra fort',
      'harmandir sahib': 'golden temple',
      'golden temple amritsar': 'golden temple',
      'bodh gaya': 'mahabodhi temple',
      'mahakumbh': 'festival',
      'kumbh': 'festival',
    };

    for (final entry in aliases.entries) {
      if (query.contains(entry.key)) {
        return query.replaceAll(entry.key, entry.value);
      }
    }

    return query;
  }

  String? _matchState(String query) {
    for (final state in _stateNames) {
      final normalized = _normalize(state);
      if (normalized.contains(query) || query.contains(normalized)) {
        return state;
      }
    }
    return null;
  }

  int? _matchCategoryIndex(String query) {
    const keywords = <int, List<String>>{
      0: ['historical', 'history', 'heritage site', 'fort', 'temple'],
      1: ['arts', 'craft', 'traditional art'],
      2: ['festival', 'celebration', 'cultural'],
      3: ['dance', 'music', 'classical'],
      4: ['language', 'literature', 'book'],
      5: ['culinary', 'food', 'dish', 'cuisine'],
    };

    for (final entry in keywords.entries) {
      for (final word in entry.value) {
        if (query.contains(word)) {
          return entry.key;
        }
      }
    }
    return null;
  }

  void _openCategoryPage(String stateName, int categoryIndex) {
    Widget page;
    switch (categoryIndex) {
      case 0:
        page = HistoricalHeritagePage(stateName: stateName);
        break;
      case 1:
        page = TraditionalArtsPage(stateName: stateName);
        break;
      case 2:
        page = FestivalsPage(stateName: stateName);
        break;
      case 3:
        page = DanceMusicPage(stateName: stateName);
        break;
      case 4:
        page = LanguageLiteraturePage(stateName: stateName);
        break;
      default:
        page = CulinaryHeritagePage(stateName: stateName);
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _runSmartSearch(String rawQuery) {
    final query = _applySearchAliases(_normalize(rawQuery));
    if (query.isEmpty) {
      return;
    }

    final queryTokens = _tokens(query);

    int bestPlaceIndex = -1;
    int bestPlaceScore = -1;

    for (var i = 0; i < _quickDestinations.length; i++) {
      final item = _quickDestinations[i];
      final title = _normalize(item['title'] ?? '');
      final state = _normalize(item['state'] ?? '');
      final description = _normalize(item['description'] ?? '');

      var score = 0;
      if (title == query) score += 120;
      if (title.contains(query)) score += 90;
      if (query.contains(title)) score += 70;
      if (state.contains(query) || query.contains(state)) score += 45;
      if (description.contains(query)) score += 30;

      if (_containsAllTokens(title, queryTokens)) score += 60;
      if (_containsAllTokens(state, queryTokens)) score += 40;

      for (final token in queryTokens) {
        if (title.contains(token)) score += 14;
        if (state.contains(token)) score += 8;
        if (description.contains(token)) score += 4;
      }

      if (score > bestPlaceScore) {
        bestPlaceScore = score;
        bestPlaceIndex = i;
      }
    }

    if (bestPlaceIndex >= 0 && bestPlaceScore >= 55) {
      final place = _quickDestinations[bestPlaceIndex];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DestinationDetailPage(
            state: place['state'] ?? '',
            place: place['title'] ?? '',
            imagePath: place['image'] ?? 'assets/icon/heritage.png',
            category: place['category'] ?? '',
            description: place['description'] ?? '',
          ),
        ),
      );
      return;
    }

    final state = _matchState(query);
    final categoryIndex = _matchCategoryIndex(query);

    if (state != null && categoryIndex != null) {
      _openCategoryPage(state, categoryIndex);
      return;
    }

    if (state != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StateCategoryPage(stateName: state),
        ),
      );
      return;
    }

    if (query.contains('gallery') || query.contains('photo')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HeritageGalleryPage()),
      );
      return;
    }

    if (query.contains('destination') || query.contains('place')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AllDestinationsPage()),
      );
      return;
    }

    if (categoryIndex != null) {
      setState(() {
        _selectedIndex = 1;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Category matched. Please select a state to continue.'),
        ),
      );
      return;
    }

    if (query.contains('notification')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NotificationsPage()),
      );
      return;
    }

    if (query.contains('about')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutPage()),
      );
      return;
    }

    if (query.contains('team')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TeamPage()),
      );
      return;
    }

    if (query.contains('add')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddDestinationPage()),
      );
      return;
    }

    setState(() {
      _selectedIndex = 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No exact match found. Try state name or place keyword.'),
      ),
    );
  }

  Widget _buildHomeSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
      child: TextField(
        controller: _homeSearchController,
        onSubmitted: _runSmartSearch,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search states, places, categories...',
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          prefixIcon:
              const Icon(Icons.travel_explore, color: Color(0xFFF5A623)),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search, color: Color(0xFFF5A623)),
            onPressed: () => _runSmartSearch(_homeSearchController.text),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4E4E9)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE4E4E9)),
          ),
        ),
      ),
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
    final media = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFFF5A623),
          elevation: 0,
          title: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Sanskriti Yatra',
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
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
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Heritage Gallery'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HeritageGalleryPage(),
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
        body: SafeArea(
          child: Column(
            children: [
              if (_selectedIndex == 0)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFFF4DD), Color(0xFFFFE9C8)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          height: media.width > 600 ? 320 : 230,
                          viewportFraction: 1,
                          enlargeCenterPage: false,
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
                                    statename: imageDetails[index]
                                        ["statename"]!,
                                    description: imageDetails[index]
                                        ["description"]!,
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    path,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Color(0xAA000000)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 12,
                                    right: 12,
                                    bottom: 12,
                                    child: Text(
                                      imageDetails[index]["title"]!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _imagePaths.asMap().entries.map((entry) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: _currentIndex == entry.key ? 22 : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(99),
                              color: _currentIndex == entry.key
                                  ? const Color(0xFFF5A623)
                                  : Colors.black26,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              if (_selectedIndex == 0) _buildHomeSearchBar(),
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: _pages,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: const Color(0xFF111111),
          unselectedItemColor: Colors.black45,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          unselectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
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
