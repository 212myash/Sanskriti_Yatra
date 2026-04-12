import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class TraditionalArtsPage extends StatefulWidget {
  final String stateName;

  const TraditionalArtsPage({super.key, required this.stateName});

  @override
  State<TraditionalArtsPage> createState() => TraditionalArtsPageState();
}

class TraditionalArtsPageState extends State<TraditionalArtsPage> {
  late final Future<List<Map<String, String>>> artsDataFuture;

  @override
  void initState() {
    super.initState();
    artsDataFuture = fetchArtsData();
  }

  Future<List<Map<String, String>>> fetchArtsData() async {
    try {
      final response = await http
          .get(ApiConfig.uri('/api/arts'))
          .timeout(ApiConfig.requestTimeout);

      if (response.statusCode != 200) {
        throw Exception('Failed to load arts data');
      }

      final decoded = ApiResponseParser.decode(response.body);
      return ApiResponseParser.stateSection(decoded, widget.stateName);
    } catch (e) {
      throw Exception('Failed to load arts data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Traditional Arts & Crafts - ${widget.stateName}"),
        backgroundColor: const Color(0xFFF5A623), // Set AppBar color
        foregroundColor: Colors.white, // Set AppBar text color
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: FutureBuilder<List<Map<String, String>>>(
        future: artsDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          final sites = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: sites.length,
            itemBuilder: (context, index) {
              final site = sites[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: site["image"]!.startsWith("http") &&
                              site["image"]!.isNotEmpty
                          ? Image.network(site["image"]!,
                              width: double.infinity, fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.broken_image, size: 64),
                              );
                            })
                          : Image.asset('assets/icon/heritage.png',
                              width: double.infinity, fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      site["name"]!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      site["description"]!,
                      textAlign: TextAlign.left,
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
