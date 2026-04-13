import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'DestinationDetailPage.dart';
import 'api_config.dart';
import 'widgets/safe_network_image.dart';

class StateHeritageListPage extends StatefulWidget {
  final String stateName;
  final String categoryTitle;

  const StateHeritageListPage({
    super.key,
    required this.stateName,
    required this.categoryTitle,
  });

  @override
  State<StateHeritageListPage> createState() => _StateHeritageListPageState();
}

class _StateHeritageListPageState extends State<StateHeritageListPage> {
  late final Future<List<Map<String, String>>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = _fetchItems();
  }

  Future<List<Map<String, String>>> _fetchItems() async {
    final assetFallbackFuture = _loadAssetFallback();
    final all = <Map<String, String>>[];
    final seen = <String>{};
    final categoryAliases = _categoryAliases(widget.categoryTitle);

    final responses = await Future.wait(
      categoryAliases.map((category) async {
        final uri = ApiConfig.uri(
          '/api/heritage?state=${Uri.encodeQueryComponent(widget.stateName)}&category=${Uri.encodeQueryComponent(category)}',
        );

        try {
          final response =
              await http.get(uri).timeout(const Duration(seconds: 6));
          if (response.statusCode != 200) {
            return const <Map<String, String>>[];
          }

          final decoded = ApiResponseParser.decode(response.body);
          final records = ApiResponseParser.heritageRecords(decoded);
          final mapped = <Map<String, String>>[];

          for (final record in records) {
            final recordState = (record['state'] ?? '').trim();
            if (recordState.isNotEmpty &&
                !_stateMatches(recordState, widget.stateName)) {
              continue;
            }

            final item = _normalizeRecord(record, categoryOverride: category);
            if (item != null) {
              mapped.add(item);
            }
          }

          return mapped;
        } catch (_) {
          return const <Map<String, String>>[];
        }
      }),
    );

    for (final group in responses) {
      for (final item in group) {
        final key =
            '${item['name']!.toLowerCase()}|${item['state']!.toLowerCase()}';
        if (seen.add(key)) {
          all.add(item);
        }
      }
    }

    if (all.isNotEmpty) {
      return all;
    }

    final byState = await _fetchByStateAndFilter();
    if (byState.isNotEmpty) {
      return byState;
    }

    final fromAll = await _fetchFromAllHeritage();
    if (fromAll.isNotEmpty) {
      return fromAll;
    }

    return assetFallbackFuture;
  }

  Future<List<Map<String, String>>> _fetchByStateAndFilter() async {
    final uri = ApiConfig.uri(
      '/api/heritage?state=${Uri.encodeQueryComponent(widget.stateName)}',
    );

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 6));
      if (response.statusCode != 200) {
        return const <Map<String, String>>[];
      }

      final decoded = ApiResponseParser.decode(response.body);
      final records = ApiResponseParser.heritageRecords(decoded);
      final keywords = _categoryFilterKeywords(widget.categoryTitle);

      final stateRecords = records
          .map((record) => _normalizeRecord(record))
          .whereType<Map<String, String>>()
          .where((record) =>
              _stateMatches(record['state'] ?? '', widget.stateName))
          .toList();

      final filtered = stateRecords.where((record) {
        final haystack =
            ('${record['category'] ?? ''} ${record['name'] ?? ''} ${record['description'] ?? ''}')
                .toLowerCase();

        return keywords.any(haystack.contains);
      }).toList();

      // If category keywords do not match backend labels, still show state data.
      return filtered.isNotEmpty ? filtered : stateRecords;
    } catch (_) {
      return const <Map<String, String>>[];
    }
  }

  Future<List<Map<String, String>>> _fetchFromAllHeritage() async {
    final uri = ApiConfig.uri('/api/heritage');

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 6));
      if (response.statusCode != 200) {
        return const <Map<String, String>>[];
      }

      final decoded = ApiResponseParser.decode(response.body);
      final records = ApiResponseParser.heritageRecords(decoded);
      final stateRecords = records
          .where((record) =>
              _stateMatches((record['state'] ?? '').trim(), widget.stateName))
          .map((record) => _normalizeRecord(record))
          .whereType<Map<String, String>>()
          .toList();

      if (stateRecords.isEmpty) {
        return const <Map<String, String>>[];
      }

      final keywords = _categoryFilterKeywords(widget.categoryTitle);
      final filtered = stateRecords.where((record) {
        final haystack =
            ('${record['category'] ?? ''} ${record['name'] ?? ''} ${record['description'] ?? ''}')
                .toLowerCase();
        return keywords.any(haystack.contains);
      }).toList();

      return filtered.isNotEmpty ? filtered : stateRecords;
    } catch (_) {
      return const <Map<String, String>>[];
    }
  }

  Map<String, String>? _normalizeRecord(
    Map<String, String> raw, {
    String? categoryOverride,
  }) {
    final state = raw['state']?.trim() ?? '';
    final name = raw['name']?.trim() ?? '';
    final image = raw['image']?.trim() ?? '';
    final description = raw['description']?.trim() ?? '';
    final category =
        (categoryOverride ?? raw['category'] ?? widget.categoryTitle).trim();

    if (name.isEmpty) {
      return null;
    }

    return <String, String>{
      'name': name,
      'state': state.isEmpty ? widget.stateName : state,
      'image': image,
      'description':
          description.isEmpty ? '$name from ${widget.stateName}.' : description,
      'category': category.isEmpty ? widget.categoryTitle : category,
    };
  }

  Future<List<Map<String, String>>> _loadAssetFallback() async {
    try {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final stateFolder = widget.stateName.replaceAll(' ', '_');
      final categoryFolder = _folderForCategory(widget.categoryTitle);
      final prefix = 'assets/images/$stateFolder/$categoryFolder/';

      final images = manifest
          .listAssets()
          .where((key) => key.startsWith(prefix))
          .where((key) =>
              key.endsWith('.png') ||
              key.endsWith('.jpg') ||
              key.endsWith('.jpeg') ||
              key.endsWith('.webp'))
          .toList()
        ..sort();

      return images.map((path) {
        final fileName = path.split('/').last;
        final dotIndex = fileName.lastIndexOf('.');
        final stem = dotIndex > 0 ? fileName.substring(0, dotIndex) : fileName;
        final formattedName = stem.replaceAll('_', ' ').trim();

        return <String, String>{
          'name': formattedName.isEmpty ? widget.categoryTitle : formattedName,
          'state': widget.stateName,
          'image': path,
          'category': widget.categoryTitle,
          'description':
              '${widget.categoryTitle} highlights for ${widget.stateName}.',
        };
      }).toList();
    } catch (_) {
      return const <Map<String, String>>[];
    }
  }

  List<String> _categoryAliases(String title) {
    final lower = title.toLowerCase();

    if (lower.contains('historical')) {
      return const <String>[
        'Historical and Heritage Sites',
        'History',
        'Historical',
        'Heritage',
      ];
    }
    if (lower.contains('arts')) {
      return const <String>[
        'Traditional Arts and Crafts',
        'Art',
        'Arts',
        'Craft',
      ];
    }
    if (lower.contains('festival')) {
      return const <String>[
        'Festivals and Cultural Celebrations',
        'Festival',
        'Culture',
      ];
    }
    if (lower.contains('dance') || lower.contains('music')) {
      return const <String>[
        'Classical Dance and Music',
        'Dance',
        'Music',
        'Performing Arts',
      ];
    }
    if (lower.contains('language')) {
      return const <String>[
        'Language and Literature',
        'Language',
        'Literature',
      ];
    }

    return const <String>[
      'Culinary Heritage',
      'Food',
      'Cuisine',
      'Culinary',
    ];
  }

  List<String> _categoryFilterKeywords(String title) {
    final lower = title.toLowerCase();

    if (lower.contains('historical')) {
      return const <String>['history', 'heritage', 'fort', 'temple'];
    }
    if (lower.contains('arts')) {
      return const <String>['art', 'craft', 'painting', 'textile'];
    }
    if (lower.contains('festival')) {
      return const <String>['festival', 'celebration', 'culture'];
    }
    if (lower.contains('dance') || lower.contains('music')) {
      return const <String>['dance', 'music', 'classical', 'performance'];
    }
    if (lower.contains('language')) {
      return const <String>['language', 'literature', 'poetry', 'script'];
    }

    return const <String>['food', 'culinary', 'dish', 'cuisine'];
  }

  String _folderForCategory(String title) {
    final lower = title.toLowerCase();

    if (lower.contains('historical')) {
      return 'Historical_and_Heritage_Sites';
    }
    if (lower.contains('arts')) {
      return 'Traditional_Arts_and_Crafts';
    }
    if (lower.contains('festival')) {
      return 'Festivals_and_Cultural_Celebrations';
    }
    if (lower.contains('dance') || lower.contains('music')) {
      return 'Festivals_and_Cultural_Celebrations';
    }
    if (lower.contains('language')) {
      return 'Language_and_Literature';
    }

    return 'Culinary_Heritage';
  }

  bool _stateMatches(String a, String b) {
    String normalize(String value) {
      return value
          .toLowerCase()
          .replaceAll('_', ' ')
          .replaceAll('-', ' ')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();
    }

    return normalize(a) == normalize(b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.categoryTitle} - ${widget.stateName}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: const Color(0xFFF5A623),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF7F8FA),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load data.'));
          }

          final items = snapshot.data ?? const <Map<String, String>>[];
          if (items.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
            itemBuilder: (context, index) {
              final item = items[index];
              final image = item['image'] ?? '';
              final name = item['name'] ?? 'Heritage';
              final state = item['state'] ?? widget.stateName;
              final description = item['description'] ?? 'No description';
              final category = item['category'] ?? widget.categoryTitle;

              return Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
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
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE8E8EC)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 190,
                            width: double.infinity,
                            child: image.isEmpty
                                ? Container(
                                    color: const Color(0xFFFFF1D9),
                                    child: const Icon(Icons.image, size: 48),
                                  )
                                : SafeNetworkImage(
                                    imagePath: image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
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
                        const SizedBox(height: 6),
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: items.length,
          );
        },
      ),
    );
  }
}
