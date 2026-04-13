import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'api_config.dart';
import 'widgets/safe_network_image.dart';

class HistoricalHeritagePage extends StatefulWidget {
  final String stateName;

  const HistoricalHeritagePage({super.key, required this.stateName});

  @override
  State<HistoricalHeritagePage> createState() => HistoricalHeritagePageState();
}

class HistoricalHeritagePageState extends State<HistoricalHeritagePage> {
  late final Future<List<Map<String, String>>> heritageFuture;

  @override
  void initState() {
    super.initState();
    heritageFuture = fetchHeritageSites();
  }

  Future<List<Map<String, String>>> fetchHeritageSites() async {
    try {
      final response = await http
          .get(ApiConfig.uri('/api/hh'))
          .timeout(ApiConfig.requestTimeout);

      if (response.statusCode == 200) {
        final decoded = ApiResponseParser.decode(response.body);
        final apiData =
            ApiResponseParser.stateSection(decoded, widget.stateName);
        if (apiData.isNotEmpty) {
          return apiData;
        }
      }
    } catch (_) {
      // Fall through to local fallback.
    }

    return _loadLocalHeritageFallback();
  }

  Future<List<Map<String, String>>> _loadLocalHeritageFallback() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);

    final stateFolder = widget.stateName.replaceAll(' ', '_');
    final prefix = 'assets/images/$stateFolder/Historical_and_Heritage_Sites/';

    final images = manifestMap.keys
        .where((key) => key.startsWith(prefix))
        .where((key) =>
            key.endsWith('.png') ||
            key.endsWith('.jpg') ||
            key.endsWith('.jpeg') ||
            key.endsWith('.webp'))
        .toList()
      ..sort();

    if (images.isEmpty) {
      return <Map<String, String>>[];
    }

    return images.map((path) {
      final fileName = path.split('/').last;
      final dotIndex = fileName.lastIndexOf('.');
      final stem = dotIndex > 0 ? fileName.substring(0, dotIndex) : fileName;
      final formattedName = stem.replaceAll('_', ' ').trim();

      return <String, String>{
        'image': path,
        'name': formattedName.isEmpty ? 'Heritage Site' : formattedName,
        'description':
            'Explore this historical heritage site from ${widget.stateName}.',
      };
    }).toList();
  }

  Widget _buildSiteImage(String imagePath) {
    return SafeNetworkImage(
      imagePath: imagePath,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historical Heritage Sites - ${widget.stateName}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: const Color(0xFFF5A623),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Map<String, String>>>(
        future: heritageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No historical data available'));
          }

          final heritageSites = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: heritageSites.length,
            itemBuilder: (context, index) {
              final site = heritageSites[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _buildSiteImage(site['image'] ?? ''),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      site['name'] ?? 'Heritage Site',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      site['description'] ?? 'No description available',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(thickness: 1, height: 20),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
