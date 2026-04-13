import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'DestinationDetailPage.dart';
import 'api_config.dart';
import 'widgets/safe_network_image.dart';

class AllDestinationsPage extends StatefulWidget {
  const AllDestinationsPage({super.key});

  @override
  State<AllDestinationsPage> createState() => _AllDestinationsPageState();
}

class _AllDestinationsPageState extends State<AllDestinationsPage> {
  late Future<List<Map<String, String>>> _destinationsFuture;

  @override
  void initState() {
    super.initState();
    _destinationsFuture = _fetchDestinations();
  }

  Future<List<Map<String, String>>> _fetchDestinations() async {
    try {
      final response = await http
          .get(ApiConfig.uri('/api/heritage'))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode != 200) {
        return _fallbackDestinations();
      }

      final decoded = ApiResponseParser.decode(response.body);
      final records = ApiResponseParser.heritageRecords(decoded);

      final mapped = records
          .map(
            (record) => <String, String>{
              'name': (record['name'] ?? '').trim(),
              'state': (record['state'] ?? '').trim(),
              'image': (record['image'] ?? '').trim(),
              'category': (record['category'] ?? '').trim(),
              'description': (record['description'] ?? '').trim(),
            },
          )
          .where((item) => item['name']!.isNotEmpty)
          .toList();

      if (mapped.isEmpty) {
        return _fallbackDestinations();
      }

      return mapped;
    } catch (_) {
      return _fallbackDestinations();
    }
  }

  List<Map<String, String>> _fallbackDestinations() {
    return <Map<String, String>>[
      {
        'name': 'Taj Mahal',
        'state': 'Uttar Pradesh',
        'image': 'assets/home_image/tajmahal.jpeg',
        'category': 'History',
        'description':
            'Iconic marble mausoleum and one of the Seven Wonders of the World.',
      },
      {
        'name': 'Golden Temple',
        'state': 'Punjab',
        'image': 'assets/home_image/golden_temple.jpg',
        'category': 'Culture',
        'description':
            'The holiest gurdwara of Sikhism and a symbol of service and unity.',
      },
      {
        'name': 'Hawa Mahal',
        'state': 'Rajasthan',
        'image': 'assets/home_image/hawa_mahal.jpg',
        'category': 'History',
        'description': 'Palace of Winds in Jaipur with iconic pink facade.',
      },
      {
        'name': 'Hampi',
        'state': 'Karnataka',
        'image': 'assets/home_image/hampi.jpeg',
        'category': 'History',
        'description':
            'Ancient Vijayanagara ruins, temples and boulder landscapes.',
      },
      {
        'name': 'Mahabodhi Temple',
        'state': 'Bihar',
        'image': 'assets/home_image/mahabodhi.jpg',
        'category': 'Historical and Heritage Sites',
        'description':
            'Sacred Buddhist site where Gautama Buddha attained enlightenment.',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      appBar: AppBar(
        title: const Text('All Destinations'),
        backgroundColor: const Color(0xFFF5A623),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _destinationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data ?? const <Map<String, String>>[];
          if (items.isEmpty) {
            return const Center(child: Text('No destinations found'));
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = items[index];
              final name = item['name'] ?? 'Destination';
              final state = item['state'] ?? 'India';
              final image = item['image'] ?? '';
              final category = item['category'] ?? '';
              final description = item['description']?.trim().isNotEmpty == true
                  ? item['description']!
                  : '$name in $state, India';

              return Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DestinationDetailPage(
                          state: state,
                          place: name,
                          imagePath: image,
                          category: category,
                          description: description,
                        ),
                      ),
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE5E6EB)),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 110,
                            height: 88,
                            child: image.isEmpty
                                ? Container(
                                    color: const Color(0xFFFFF1D9),
                                    child: const Icon(Icons.image, size: 34),
                                  )
                                : SafeNetworkImage(
                                    imagePath: image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1F1F27),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$state, India',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              if (category.trim().isNotEmpty) ...[
                                const SizedBox(height: 5),
                                Text(
                                  category,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFFAA6E00),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
