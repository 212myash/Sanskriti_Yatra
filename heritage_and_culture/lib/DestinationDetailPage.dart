import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_config.dart';
import 'widgets/safe_network_image.dart';

class DestinationDetailPage extends StatefulWidget {
  final String state;
  final String place;
  final String imagePath;
  final String description;
  final String category;

  const DestinationDetailPage({
    super.key,
    required this.state,
    required this.place,
    this.imagePath = '',
    this.description = '',
    this.category = '',
  });

  @override
  State<DestinationDetailPage> createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage> {
  late Future<_HeritageDetail> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = _fetchDetail();
  }

  String _normalize(String value) {
    return value.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  List<String> _tokens(String value) {
    return _normalize(value)
        .split(' ')
        .where((e) => e.trim().isNotEmpty)
        .toList();
  }

  String _normalizeName(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9 ]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  bool _stateMatches(String a, String b) {
    String normalizeState(String value) {
      return value
          .toLowerCase()
          .replaceAll('_', ' ')
          .replaceAll('-', ' ')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();
    }

    final left = normalizeState(a);
    final right = normalizeState(b);
    if (left.isEmpty || right.isEmpty) {
      return true;
    }
    return left == right;
  }

  bool _nameMatches(String candidate, String query) {
    final a = _normalizeName(candidate);
    final b = _normalizeName(query);
    if (a.isEmpty || b.isEmpty) {
      return false;
    }
    return a == b || a.contains(b) || b.contains(a);
  }

  int _scoreItem(Map<String, dynamic> item, String queryName) {
    final name = _normalize(item['name']?.toString() ?? '');
    final description = _normalize(item['description']?.toString() ?? '');
    final query = _normalize(queryName);

    if (name.isEmpty) {
      return -1;
    }

    var score = 0;
    if (name == query) score += 120;
    if (name.contains(query)) score += 90;
    if (query.contains(name)) score += 60;
    if (description.contains(query)) score += 30;

    final queryTokens = _tokens(query);
    for (final token in queryTokens) {
      if (name.contains(token)) score += 10;
      if (description.contains(token)) score += 4;
    }

    return score;
  }

  _HeritageDetail _toDetail(Map<String, dynamic> map) {
    final name = (map['name'] ?? widget.place).toString().trim();
    final state = (map['state'] ?? widget.state).toString().trim();
    final category = (map['category'] ?? widget.category).toString().trim();
    final description = (map['description'] ?? '').toString().trim();
    final image = (map['image'] ?? widget.imagePath).toString().trim();

    final enhancedDescription =
        _enhanceDescription(name, category, description);
    final generated = enhanceContent(name, category);

    return _HeritageDetail(
      name: name.isEmpty ? widget.place : name,
      state: state.isEmpty ? widget.state : state,
      category: category.isEmpty ? 'Culture' : category,
      description: enhancedDescription,
      image: image,
      funFact: generated['funFact'] ?? '',
      origin: generated['origin'] ?? '',
      significance: generated['significance'] ?? '',
    );
  }

  String _enhanceDescription(
      String title, String category, String rawDescription) {
    final desc = rawDescription.trim();
    if (desc.length >= 80) {
      return desc;
    }

    final scopedCategory = category.trim().isEmpty ? 'heritage' : category;
    final base = desc.isEmpty
        ? '$title is a remarkable part of India\'s cultural landscape.'
        : desc;

    return '$base It is associated with $scopedCategory traditions and offers visitors a deeper understanding of the region\'s history, art, and living culture.';
  }

  Future<_HeritageDetail> _fetchWithUri(Uri uri) async {
    final response = await http.get(uri).timeout(ApiConfig.requestTimeout);
    if (response.statusCode != 200) {
      throw Exception('Request failed with status ${response.statusCode}');
    }

    final decoded = ApiResponseParser.decode(response.body);
    final items = ApiResponseParser.collectionItems(decoded)
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    if (items.isEmpty) {
      throw Exception('No data found');
    }

    final stateScoped = items
        .where((item) => _stateMatches(
              item['state']?.toString() ?? '',
              widget.state,
            ))
        .toList();

    final byState = stateScoped.isNotEmpty ? stateScoped : items;

    final exactName = byState
        .where((item) => _normalizeName(item['name']?.toString() ?? '') ==
            _normalizeName(widget.place))
        .toList();

    final nameMatched = exactName.isNotEmpty
        ? exactName
        : byState
            .where(
              (item) => _nameMatches(item['name']?.toString() ?? '', widget.place),
            )
            .toList();

    if (nameMatched.isEmpty) {
      throw Exception('No matching detail found for selected tile');
    }

    nameMatched.sort((a, b) =>
        _scoreItem(b, widget.place).compareTo(_scoreItem(a, widget.place)));

    final selected = nameMatched.first;
    final merged = <String, dynamic>{
      ...selected,
      if (widget.place.trim().isNotEmpty) 'name': widget.place.trim(),
      if (widget.state.trim().isNotEmpty) 'state': widget.state.trim(),
      if (widget.category.trim().isNotEmpty) 'category': widget.category.trim(),
      if ((selected['description']?.toString().trim().isEmpty ?? true) &&
          widget.description.trim().isNotEmpty)
        'description': widget.description.trim(),
      if ((selected['image']?.toString().trim().isEmpty ?? true) &&
          widget.imagePath.trim().isNotEmpty)
        'image': widget.imagePath.trim(),
    };

    return _toDetail(merged);
  }

  Future<_HeritageDetail> _fetchDetail() async {
    final encodedState = Uri.encodeQueryComponent(widget.state.trim());
    final categoriesToTry = <String>[];

    if (widget.category.trim().isNotEmpty) {
      categoriesToTry.add(widget.category.trim());
    } else {
      categoriesToTry.addAll(const <String>[
        'Culture',
        'Art',
        'Festival',
        'Dance',
        'Literature',
        'Food',
        'Tourism',
        'History',
      ]);
    }

    for (final category in categoriesToTry) {
      final encodedCategory = Uri.encodeQueryComponent(category);
      final uri = ApiConfig.uri(
        '/api/heritage?state=$encodedState&category=$encodedCategory',
      );

      try {
        return await _fetchWithUri(uri);
      } catch (_) {
        // Try next category/state fallback.
      }
    }

    try {
      final fallbackUri = ApiConfig.uri('/api/heritage?state=$encodedState');
      return await _fetchWithUri(fallbackUri);
    } catch (_) {
      // Try global endpoint before local fallback.
    }

    try {
      final globalUri = ApiConfig.uri('/api/heritage');
      return await _fetchWithUri(globalUri);
    } catch (_) {
      // Final fallback uses card payload.
    }

    return _localFallbackDetail();
  }

  _HeritageDetail _localFallbackDetail() {
    return _toDetail(<String, dynamic>{
      'name': widget.place,
      'state': widget.state,
      'category': widget.category,
      'description': widget.description,
      'image': widget.imagePath,
    });
  }

  Map<String, String> enhanceContent(String title, String category) {
    final scopedCategory = category.trim().isEmpty ? 'cultural' : category;

    return <String, String>{
      'funFact':
          'Many local communities preserve $title through festivals, oral stories, and craft traditions linked with $scopedCategory heritage.',
      'origin':
          '$title evolved over centuries through regional influences, patronage, and community practices, becoming an identity marker of its area.',
      'significance':
          '$title represents the artistic memory of the region and helps people connect with their language, rituals, and traditional worldview.',
    };
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFF5A623), size: 20),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  String _formatLocation(String fetchedState) {
    final apiState = fetchedState.trim();
    final selectedState = widget.state.trim();

    final hasSelectedState =
        selectedState.isNotEmpty && selectedState.toLowerCase() != 'india';
    if (hasSelectedState) {
      if (apiState.isEmpty || apiState.toLowerCase() == 'india') {
        return '$selectedState, India';
      }

      if (apiState.toLowerCase() == selectedState.toLowerCase()) {
        return '$selectedState, India';
      }

      if (apiState.toLowerCase().contains('india')) {
        return apiState;
      }

      return '$apiState, India';
    }

    return apiState.isEmpty ? 'India' : apiState;
  }

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFF5A623)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 15, height: 1.45),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_rounded,
                size: 52, color: Colors.black54),
            const SizedBox(height: 10),
            const Text(
              'No data found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'We could not load detail data right now. Please try again.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _detailFuture = _fetchDetail();
                });
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5A623),
        title: Text(
          widget.place,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: FutureBuilder<_HeritageDetail>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return _buildErrorState(snapshot.error ?? 'Unknown error');
          }

          final detail = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 260,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        detail.image.isEmpty
                            ? Container(
                                color: const Color(0xFFFFF1D9),
                                child: const Icon(Icons.image, size: 72),
                              )
                            : const SizedBox.shrink(),
                        if (detail.image.isNotEmpty)
                          SafeNetworkImage(
                            imagePath: detail.image,
                            fit: BoxFit.cover,
                            fallbackAsset: 'assets/icon/heritage.png',
                          ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color(0xB3000000)],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 14,
                          right: 14,
                          bottom: 14,
                          child: Text(
                            detail.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              height: 1.15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _infoRow(
                        Icons.location_on_rounded,
                        'Location',
                        _formatLocation(detail.state),
                      ),
                      const SizedBox(height: 8),
                      _infoRow(Icons.theater_comedy_rounded, 'Category',
                          detail.category),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _sectionCard(
                  icon: Icons.description_rounded,
                  title: 'Description',
                  content: detail.description,
                ),
                _sectionCard(
                  icon: Icons.auto_awesome_rounded,
                  title: 'Fun Fact',
                  content: detail.funFact,
                ),
                _sectionCard(
                  icon: Icons.history_edu_rounded,
                  title: 'Origin / History',
                  content: detail.origin,
                ),
                _sectionCard(
                  icon: Icons.diversity_3_rounded,
                  title: 'Cultural Significance',
                  content: detail.significance,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeritageDetail {
  final String name;
  final String state;
  final String category;
  final String description;
  final String image;
  final String funFact;
  final String origin;
  final String significance;

  const _HeritageDetail({
    required this.name,
    required this.state,
    required this.category,
    required this.description,
    required this.image,
    required this.funFact,
    required this.origin,
    required this.significance,
  });
}
