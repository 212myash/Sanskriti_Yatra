import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class HeritageGalleryPage extends StatefulWidget {
  const HeritageGalleryPage({super.key});

  @override
  State<HeritageGalleryPage> createState() => _HeritageGalleryPageState();
}

class _HeritageGalleryPageState extends State<HeritageGalleryPage> {
  final List<String> _states = const [
    'All',
    'Rajasthan',
    'Kerala',
    'Punjab',
    'Tamil Nadu',
    'Maharashtra',
    'India',
  ];

  final List<String> _categories = const [
    'All',
    'Culture',
    'Tourism',
    'Festival',
    'Temple',
    'Food',
    'Dance',
    'Heritage Monuments',
  ];

  String _selectedState = 'All';
  String _selectedCategory = 'All';
  late Future<List<Map<String, String>>> _heritageFuture;

  @override
  void initState() {
    super.initState();
    _heritageFuture = _fetchHeritage();
  }

  Future<List<Map<String, String>>> _fetchHeritage() async {
    final queryParameters = <String, String>{};

    if (_selectedState != 'All') {
      queryParameters['state'] = _selectedState;
    }
    if (_selectedCategory != 'All') {
      queryParameters['category'] = _selectedCategory;
    }

    final uri = ApiConfig.uri('/api/heritage')
        .replace(queryParameters: queryParameters);
    final response = await http.get(uri).timeout(ApiConfig.requestTimeout);

    if (response.statusCode != 200) {
      throw Exception('Failed to load heritage data (${response.statusCode})');
    }

    final decoded = ApiResponseParser.decode(response.body);
    final items = ApiResponseParser.collectionItems(decoded);

    return items.whereType<Map>().map((item) {
      final map = Map<String, dynamic>.from(item);
      return {
        'state': map['state']?.toString() ?? '',
        'category': map['category']?.toString() ?? '',
        'name': map['name']?.toString() ?? '',
        'image': map['image']?.toString() ?? '',
        'description': map['description']?.toString() ?? '',
      };
    }).toList();
  }

  void _reloadData() {
    setState(() {
      _heritageFuture = _fetchHeritage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heritage Gallery'),
        backgroundColor: const Color(0xFFF5A623),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Explore seeded Pexels heritage data',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedState,
                      decoration: const InputDecoration(
                        labelText: 'State',
                        border: OutlineInputBorder(),
                      ),
                      items: _states
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedState = value;
                        });
                        _reloadData();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: _categories
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedCategory = value;
                        });
                        _reloadData();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _reloadData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5A623),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Load Heritage Data'),
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<Map<String, String>>>(
                future: _heritageFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  final items = snapshot.data ?? [];
                  if (items.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                            'No heritage data found for the selected filters.'),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _HeritageCard(item: item);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeritageCard extends StatelessWidget {
  final Map<String, String> item;

  const _HeritageCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final imageUrl = item['image'] ?? '';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: imageUrl.isEmpty
                ? Container(
                    color: Colors.orange.shade50,
                    child: const Icon(Icons.image_not_supported, size: 48),
                  )
                : Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.orange.shade50,
                        child: const Icon(Icons.broken_image, size: 48),
                      );
                    },
                  ),
          ),
          Container(
            color: const Color(0xFFF5A623),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item['state'] ?? ''} • ${item['category'] ?? ''}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
