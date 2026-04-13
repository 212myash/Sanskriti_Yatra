import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'widgets/safe_network_image.dart';

class CulinaryHeritagePage extends StatefulWidget {
  final String stateName;

  const CulinaryHeritagePage({super.key, required this.stateName});

  @override
  State<CulinaryHeritagePage> createState() => CulinaryHeritagePagePage();
}

class CulinaryHeritagePagePage extends State<CulinaryHeritagePage> {
  late final Future<List<Map<String, String>>> artsDataFuture;

  @override
  void initState() {
    super.initState();
    artsDataFuture = fetchArtsData();
  }

  Future<List<Map<String, String>>> fetchArtsData() async {
    try {
      final response = await http
          .get(ApiConfig.uri('/api/c'))
          .timeout(ApiConfig.requestTimeout);

      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      }

      final decoded = ApiResponseParser.decode(response.body);
      return ApiResponseParser.stateSection(decoded, widget.stateName);
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Culinary Heritage - ${widget.stateName}"),
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
                      child: SafeNetworkImage(
                        imagePath: site["image"] ?? '',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
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
