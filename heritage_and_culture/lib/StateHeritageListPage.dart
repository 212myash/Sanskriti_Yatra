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

    // Try state-level fetch first
    final byState = await _fetchByStateAndFilter();
    if (byState.isNotEmpty) {
      return byState;
    }

    // Fallback to all heritage data filtered by state
    final fromAll = await _fetchFromAllHeritage();
    if (fromAll.isNotEmpty) {
      return fromAll;
    }

    // Final fallback to local assets
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

      // Filter by state and normalize all records
      final stateRecords = records
          .map((record) => _normalizeRecord(record))
          .whereType<Map<String, String>>()
          .where((record) =>
              _stateMatches(record['state'] ?? '', widget.stateName))
          .toList();

      // Return all state records - no category filtering here
      return stateRecords;
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

      // Filter by state and normalize all records
      final stateRecords = records
          .where((record) =>
              _stateMatches((record['state'] ?? '').trim(), widget.stateName))
          .map((record) => _normalizeRecord(record))
          .whereType<Map<String, String>>()
          .toList();

      // Return all state records - no category filtering here
      return stateRecords;
    } catch (_) {
      return const <Map<String, String>>[];
    }
  }

  Map<String, String>? _normalizeRecord(
    Map<String, String> raw, {
    String? categoryOverride,
  }) {
    final recordState = raw['state']?.trim() ?? '';
    final name = raw['name']?.trim() ?? '';
    final image = raw['image']?.trim() ?? '';
    final description = raw['description']?.trim() ?? '';
    final category =
        (categoryOverride ?? raw['category'] ?? widget.categoryTitle).trim();

    if (name.isEmpty) {
      return null;
    }

    // Use selected state if record state is empty or doesn't match
    final finalState =
        (recordState.isEmpty || !_stateMatches(recordState, widget.stateName))
            ? widget.stateName
            : recordState;

    return <String, String>{
      'name': name,
      'state': finalState,
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

  Widget _summaryHeader(int count) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFDDA7)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1D9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.temple_buddhist_rounded,
              color: Color(0xFFB17000),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.categoryTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F1F27),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${widget.stateName} • $count places',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeritageCard(Map<String, String> item, BuildContext context) {
    final image = item['image'] ?? '';
    final name = item['name'] ?? 'Heritage';
    final state = item['state'] ?? widget.stateName;
    final description = item['description'] ?? 'No description';
    final category = item['category'] ?? widget.categoryTitle;

    return Material(
      color: Colors.white,
      elevation: 0,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
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
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE5E6EB)),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFFFFF), Color(0xFFFCFCFD)],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 196,
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
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    size: 15,
                    color: Colors.black45,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '$state, India',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: const Color(0xFFF5A623),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF2F3F7),
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

          return Column(
            children: [
              _summaryHeader(items.length),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
                  itemBuilder: (context, index) {
                    return _buildHeritageCard(items[index], context);
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: items.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
