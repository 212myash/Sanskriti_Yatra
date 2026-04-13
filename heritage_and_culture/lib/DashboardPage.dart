import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'package:testapp/AllDestinationsPage.dart';
import 'package:testapp/DestinationDetailPage.dart';
import 'package:testapp/Home.dart';
import 'widgets/safe_network_image.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = fetchUsers();
  }

  // Function to fetch users from API
  Future<List<User>> fetchUsers() async {
    try {
      final response = await http
          .get(ApiConfig.uri('/api/heritage'))
          .timeout(ApiConfig.requestTimeout);

      if (response.statusCode != 200) {
        return _fallbackUsers();
      }

      final decoded = ApiResponseParser.decode(response.body);
      final users = ApiResponseParser.heritageRecords(decoded);
      final mapped = users
          .map((userData) => User.fromJson(Map<String, dynamic>.from(userData)))
          .toList();

      final withImages =
          mapped.where((user) => user.image.trim().isNotEmpty).toList();
      final effective = withImages.isNotEmpty ? withImages : mapped;

      if (effective.isEmpty) {
        return _fallbackUsers();
      }

      return effective;
    } catch (_) {
      return _fallbackUsers();
    }
  }

  List<User> _fallbackUsers() {
    return <User>[
      User(
        image: 'assets/home_image/Agra_Fort.jpg',
        name: 'Taj Mahal',
        state: 'Uttar Pradesh',
        category: 'Culture',
        description: 'Iconic marble mausoleum and world heritage monument.',
      ),
      User(
        image: 'assets/home_image/golden_temple.jpg',
        name: 'Golden Temple',
        state: 'Punjab',
        category: 'Culture',
        description: 'The holiest gurdwara of Sikhism in Amritsar.',
      ),
      User(
        image: 'assets/home_image/hawa_mahal.jpg',
        name: 'Hawa Mahal',
        state: 'Rajasthan',
        category: 'History',
        description: 'Historic pink sandstone palace in Jaipur.',
      ),
      User(
        image: 'assets/home_image/hampi.jpeg',
        name: 'Hampi',
        state: 'Karnataka',
        category: 'History',
        description: 'Ancient Vijayanagara ruins and UNESCO site.',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final titleSize = width < 360 ? 20.0 : 26.0;
    final cardAspect = width < 360 ? 0.72 : 0.78;

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFCF6),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFFFE2AD), width: 1),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              "Popular Heritage Picks",
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.2,
                color: Color(0xFF1F1F27),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            const Text(
              'Curated landmarks, temples, forts and living culture',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              child: FutureBuilder<List<User>>(
                future: _usersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Showing offline heritage picks.'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No destinations found.'));
                  } else {
                    final users = snapshot.data!;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: cardAspect,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final cardTitle = _titleForCard(user, index);
                        final cardSubtitle = _subtitleForCard(user, index);
                        return _buildDestinationCard(
                          context,
                          user.image,
                          user.name,
                          user.state,
                          user.category,
                          user.description,
                          cardTitle,
                          cardSubtitle,
                        );
                      },
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllDestinationsPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xFF141414)),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
              child: const Text(
                'Explore All Destinations',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create a destination card
  Widget _buildDestinationCard(
      BuildContext context,
      String imagePath,
      String name,
      String state,
      String category,
      String description,
      String cardTitle,
      String cardSubtitle) {
    final path = _resolveImagePath(name, state, imagePath.trim());

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailPage(
              state: state,
              place: name,
              imagePath: imagePath,
              category: category,
              description: description,
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: _buildCardImage(path),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
              child: Column(
                children: [
                  Text(
                    cardTitle,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF222129),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cardSubtitle,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardImage(String path) {
    return SafeNetworkImage(
      imagePath: path,
      fit: BoxFit.cover,
    );
  }

  String _resolveImagePath(String name, String state, String imagePath) {
    if (imagePath.isNotEmpty) {
      return imagePath;
    }

    final key = '${name.toLowerCase().trim()}|${state.toLowerCase().trim()}';
    const localFallback = <String, String>{
      'taj mahal|uttar pradesh': 'assets/home_image/Agra_Fort.jpg',
      'hawa mahal|rajasthan': 'assets/home_image/hawa_mahal.jpg',
      'golden temple|punjab': 'assets/home_image/golden_temple.jpg',
      'hampi|karnataka': 'assets/home_image/hampi.jpeg',
      'mahabodhi temple|bihar': 'assets/home_image/mahabodhi.jpg',
      'kedarnath|uttarakhand': 'assets/home_image/Kedarnath.jpg',
      'agra fort|uttar pradesh': 'assets/home_image/Agra_Fort.jpg',
      'ayodhya|uttar pradesh': 'assets/home_image/Ayodhya.jpeg',
    };

    return localFallback[key] ?? 'assets/icon/heritage.png';
  }

  String _titleForCard(User user, int index) {
    final name = user.name.trim();
    if (name.isNotEmpty && name.length <= 32 && !_looksLikeCaption(name)) {
      return name;
    }

    final fromDescription = _extractTitleFromText(user.description);
    if (fromDescription.isNotEmpty) {
      return fromDescription;
    }

    final category = user.category.trim();
    if (category.isNotEmpty) {
      return '$category Pick ${index + 1}';
    }

    return 'Heritage Pick ${index + 1}';
  }

  String _subtitleForCard(User user, int index) {
    final category = user.category.trim();
    final state = user.state.trim();

    if (category.isNotEmpty &&
        state.isNotEmpty &&
        state.toLowerCase() != 'india') {
      return '$state • $category';
    }

    final desc = user.description.trim();
    if (desc.isNotEmpty) {
      return _shortText(desc, 42);
    }

    if (state.isNotEmpty) {
      return state;
    }

    return 'Unique detail ${index + 1}';
  }

  bool _looksLikeCaption(String text) {
    final normalized = text.toLowerCase();
    return normalized.startsWith('a ') ||
        normalized.startsWith('an ') ||
        normalized.contains('performs') ||
        normalized.contains('showcasing') ||
        normalized.split(' ').length > 7;
  }

  String _extractTitleFromText(String text) {
    final cleaned = text
        .replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();

    if (cleaned.isEmpty) {
      return '';
    }

    final words = cleaned.split(' ').where((w) => w.isNotEmpty).toList();
    final filtered = words.where((word) {
      const stop = <String>{
        'a',
        'an',
        'the',
        'in',
        'on',
        'of',
        'with',
        'and',
        'showcasing',
        'traditional',
      };
      return !stop.contains(word.toLowerCase());
    }).toList();

    final picked = (filtered.isEmpty ? words : filtered).take(4).toList();
    if (picked.isEmpty) {
      return '';
    }

    return picked
        .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
        .join(' ');
  }

  String _shortText(String text, int maxChars) {
    final cleaned = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (cleaned.length <= maxChars) {
      return cleaned;
    }
    return '${cleaned.substring(0, maxChars - 1)}…';
  }
}
