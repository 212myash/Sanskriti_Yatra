import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'Home.dart';
import 'StateCategoryPage.dart';
import 'widgets/safe_network_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Map<String, String> _stateImageByName = {};

  final List<String> states = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal"
  ];

  late List<String> filteredStates;

  @override
  void initState() {
    super.initState();
    filteredStates = states;
    _loadStateThumbnails();
  }

  Future<void> _loadStateThumbnails() async {
    try {
      final response = await http
          .get(ApiConfig.uri('/api/heritage'))
          .timeout(ApiConfig.requestTimeout);

      if (response.statusCode != 200) {
        return;
      }

      final decoded = ApiResponseParser.decode(response.body);
      final records = ApiResponseParser.heritageRecords(decoded);
      final imageByState = <String, String>{};

      for (final record in records) {
        final state = (record['state'] ?? '').trim();
        final image = (record['image'] ?? '').trim();
        if (state.isEmpty || image.isEmpty) {
          continue;
        }

        final key = state.toLowerCase();
        imageByState.putIfAbsent(key, () => image);
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _stateImageByName
          ..clear()
          ..addAll(imageByState);
      });
    } catch (_) {
      // Keep static fallback when API image fetch fails.
    }
  }

  void filterStates(String query) {
    setState(() {
      filteredStates = states
          .where((state) => state.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final headingSize = width < 360 ? 34.0 : 38.0;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Which State Are You Looking For?',
                style: TextStyle(
                  fontSize: headingSize,
                  height: 1.12,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF181A1F),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                onChanged: filterStates,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5A623),
                  hintText: "Search for a state",
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  suffixIcon: _controller.text.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            _controller.clear();
                            filterStates('');
                          },
                        ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Scrollbar(
                  controller: _scrollController,
                  radius: const Radius.circular(10),
                  thickness: 5,
                  thumbVisibility: true,
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: filteredStates.length,
                    itemBuilder: (context, index) {
                      final stateName = filteredStates[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StateCategoryPage(stateName: stateName),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFE7E8EC),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              _buildStateThumbnail(stateName),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  stateName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF22242B),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStateThumbnail(String stateName) {
    final apiImagePath =
        _stateImageByName[stateName.toLowerCase().trim()] ?? '';
    final localImagePath = _localStateAsset(stateName);
    final imagePath = apiImagePath.isNotEmpty ? apiImagePath : localImagePath;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 34,
        height: 34,
        child: imagePath.isEmpty
            ? _fallbackThumb()
            : SafeNetworkImage(
                imagePath: imagePath,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _fallbackThumb() {
    return Container(
      color: const Color(0xFFFFF1D9),
      child: const Icon(
        Icons.location_on_outlined,
        size: 18,
        color: Color(0xFFCC8614),
      ),
    );
  }

  String _localStateAsset(String stateName) {
    const map = <String, String>{
      'andhra pradesh':
          'assets/images/Andhra_Pradesh/Culinary_Heritage/Gongura_Pachadi.jpg',
      'arunachal pradesh':
          'assets/images/Arunachal_Pradesh/Culinary_Heritage/Apong.jpg',
      'assam': 'assets/images/Assam/Culinary_Heritage/Aloo_Pitika.jpg',
      'bihar': 'assets/images/Bihar/Culinary_Heritage/Litti_Chokha.jpg',
      'chhattisgarh': 'assets/images/Chhattisgarh/Culinary_Heritage/Chila.jpeg',
      'goa': 'assets/images/Goa/Culinary_Heritage/Bebinca.jpg',
      'gujarat': 'assets/images/Gujarat/Culinary_Heritage/Dhokla.jpeg',
      'haryana': 'assets/images/Haryana/Culinary_Heritage/Bajra_Khichdi.webp',
      'himachal pradesh':
          'assets/images/Himachal_Pradesh/Culinary_Heritage/Dham.jpg',
      'jharkhand': 'assets/images/Jharkhand/Culinary_Heritage/Chhilka.jpg',
      'karnataka':
          'assets/images/Karnataka/Culinary_Heritage/Bisi_Bele_Bath.jpg',
      'kerala': 'assets/images/Kerala/Culinary_Heritage/Avial.jpg',
      'madhya pradesh':
          'assets/images/Madhya_Pradesh/Culinary_Heritage/Bhutte_Ki_Kees.jpg',
      'maharashtra':
          'assets/images/Maharashtra/Culinary_Heritage/Misal_Pav.jpg',
      'manipur': 'assets/images/Manipur/Culinary_Heritage/Chamthong.jpg',
      'meghalaya': 'assets/images/Meghalaya/Culinary_Heritage/Jadoh.jpg',
      'mizoram': 'assets/images/Mizoram/Culinary_Heritage/Bai.webp',
      'nagaland': 'assets/images/Nagaland/Culinary_Heritage/Galho.jpg',
      'odisha': 'assets/images/Odisha/Culinary_Heritage/Chhena_Poda.jpg',
      'punjab': 'assets/images/Punjab/Culinary_Heritage/Chole_Bhature.jpg',
      'rajasthan':
          'assets/images/Rajasthan/Culinary_Heritage/Dal_Bati_Choorma.jpg',
      'sikkim': 'assets/images/Sikkim/Culinary_Heritage/Chhurpi.jpg',
      'tamil nadu': 'assets/images/Tamil_Nadu/Culinary_Heritage/Dosa.jpg',
      'telangana':
          'assets/images/Telangana/Culinary_Heritage/Hyderabadi_Biryani.jpg',
      'tripura': 'assets/images/Tripura/Culinary_Heritage/Bamboo_Shoot.webp',
      'uttarakhand':
          'assets/images/Uttarakhand/Culinary_Heritage/Aloo_Tamatar_Jhol.jpg',
      'uttar pradesh':
          'assets/images/Uttar_Pradesh/Culinary_Heritage/Awadhi_Cuisine.jpeg',
      'west bengal':
          'assets/images/West_Bengal/Culinary_Heritage/Macher_Jhol.jpg',
    };

    return map[stateName.toLowerCase().trim()] ?? '';
  }
}
