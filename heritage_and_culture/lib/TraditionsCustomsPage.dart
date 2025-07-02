import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TraditionsCustomsPage extends StatefulWidget {
  final String stateName;

  const TraditionsCustomsPage({super.key, required this.stateName});

  @override
  TraditionsCustomsPageState createState() => TraditionsCustomsPageState();
}

class TraditionsCustomsPageState extends State<TraditionsCustomsPage> {
  late Future<List<Map<String, String>>> traditionsFuture;

  @override
  void initState() {
    super.initState();
    traditionsFuture = fetchTraditions();
  }

  Future<List<Map<String, String>>> fetchTraditions() async {
    try {
      final response = await http.get(
        Uri.parse("https://test2342.vercel.app/api/uc"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final userData = data['users'] as List<dynamic>?;

        if (userData != null && userData.isNotEmpty) {
          final stateData = userData.first[widget.stateName] as List<dynamic>?;

          return stateData
                  ?.map((item) => {
                        "image": (item["image"] ?? "").toString(),
                        "name": (item["name"] ?? "Unknown Name").toString(),
                        "description":
                            (item["description"] ?? "No description available")
                                .toString()
                      })
                  .toList() ??
              [];
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unique Traditions & Customs - ${widget.stateName}"),
        backgroundColor: const Color(0xFFF5A623), // Set AppBar color
        foregroundColor: Colors.white, // Set AppBar text color
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: FutureBuilder<List<Map<String, String>>>(
        future: traditionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No traditions available"));
          }

          final traditions = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: traditions.length,
            itemBuilder: (context, index) {
              final tradition = traditions[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: tradition["image"]!.startsWith("http") &&
                              tradition["image"]!.isNotEmpty
                          ? Image.network(
                              tradition["image"]!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/placeholder.png',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      tradition["name"]!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      tradition["description"]!,
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
