import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Create a model class to represent a User
class User {
  final String image;
  final String name;
  final String state;
  final String description;

  User(
      {required this.image,
      required this.name,
      required this.state,
      required this.description});

  // Convert a JSON object into a User instance
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      image: json['image'],
      name: json['name'],
      state: json['state'],
      description: json['description'],
    );
  }
}

// UserList widget to fetch and display users
class UserList extends StatelessWidget {
  const UserList({super.key});

  // Function to fetch users from the API
  Future<List<User>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://172.22.131.221:8000/users'));

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
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: FutureBuilder<List<User>>(
        future: fetchUsers(), // Call the fetchUsers function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the data
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Show an error message if something went wrong
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Handle case where no data is returned
            return Center(child: Text('No users found.'));
          } else {
            // Display the list of users if data is successfully fetched
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: user.image.isEmpty
                      ? Icon(Icons
                          .account_circle) // Default icon if no image is provided
                      : Image.network(user.image,
                          width: 50, height: 50), // Display user image
                  title: Text(user.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.state),
                      Text(user.description),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
