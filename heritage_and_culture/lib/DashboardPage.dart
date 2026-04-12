import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'package:testapp/AllDestinationsPage.dart';
import 'package:testapp/DestinationDetailPage.dart';
import 'package:testapp/Home.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = fetchUsers();
  }

  // Function to fetch users from API
  Future<List<User>> fetchUsers() async {
    final response = await http
        .get(ApiConfig.uri('/api/posts'))
        .timeout(ApiConfig.requestTimeout);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load destinations (${response.statusCode}): ${response.body}',
      );
    }

    final decoded = ApiResponseParser.decode(response.body);
    final users = ApiResponseParser.heritageRecords(decoded);
    return users
        .map((userData) => User.fromJson(Map<String, dynamic>.from(userData)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 25),
          const Text(
            "Popular Place",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<List<User>>(
              future: _usersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No destinations found.'));
                } else {
                  final users = snapshot.data!;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return _buildDestinationCard(
                        context,
                        user.image,
                        user.name,
                        user.state,
                        user.description,
                      );
                    },
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AllDestinationsPage()),
              );
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromRGBO(0, 0, 0, 1)),
            ),
            child: const Text(
              'See All',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Method to create a destination card
  Widget _buildDestinationCard(BuildContext context, String imagePath,
      String name, String state, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailPage(
              state: state,
              place: name,
              imagePath: imagePath,
              description: description,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: imagePath.isEmpty
                    ? const Center(
                        child: Icon(Icons.account_circle, size: 100),
                      )
                    : Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.broken_image, size: 100),
                          );
                        },
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
