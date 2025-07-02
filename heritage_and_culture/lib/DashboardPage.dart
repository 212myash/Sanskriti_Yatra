import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/AllDestinationsPage.dart';
import 'package:testapp/DestinationDetailPage.dart';
import 'package:testapp/Home.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // Function to fetch users from API
  Future<List<User>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://test2342.vercel.app/api/posts'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      final List<dynamic> data = json.decode(response.body)['users'];
      return data.map((userData) => User.fromJson(userData)).toList();
    } else {
      // If the server returns an error response, throw an exception.
      throw Exception('Failed to load users');
    }
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
              future: fetchUsers(), // Fetching users data
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
                    ? const Icon(Icons.account_circle, size: 100)
                    : Image.network(imagePath, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Roboto')),
            ),
          ],
        ),
      ),
    );
  }
}
