// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_config.dart';

class AddDestinationPage extends StatefulWidget {
  const AddDestinationPage({super.key});

  @override
  _AddDestinationPageState createState() => _AddDestinationPageState();
}

class _AddDestinationPageState extends State<AddDestinationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _imageController.dispose();
    _nameController.dispose();
    _stateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Function to send the data to the server via POST request
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http
            .post(
              ApiConfig.uri('/api/post/test'),
              headers: {'Content-Type': 'application/json'},
              body: json.encode({
                'image': _imageController.text.trim(),
                'name': _nameController.text.trim(),
                'state': _stateController.text.trim(),
                'description': _descriptionController.text.trim(),
              }),
            )
            .timeout(ApiConfig.requestTimeout);

        if (!mounted) {
          return;
        }

        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Destination added successfully!')),
          );
          _imageController.clear();
          _nameController.clear();
          _stateController.clear();
          _descriptionController.clear();
        } else {
          String message = 'Failed to add destination';
          try {
            final decoded = ApiResponseParser.decode(response.body);
            if (decoded is Map<String, dynamic>) {
              message = decoded['message']?.toString() ?? message;
            }
          } catch (_) {
            message = response.reasonPhrase ?? message;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add destination: $message')),
          );
        }
      } catch (error) {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred: $error')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Destination',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFF5A623),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                  controller: _imageController,
                  label: 'Image URL',
                  validatorText: 'Please enter an image URL'),
              const SizedBox(height: 10),
              _buildTextField(
                  controller: _nameController,
                  label: 'Destination Name',
                  validatorText: 'Please enter the destination name'),
              const SizedBox(height: 10),
              _buildTextField(
                  controller: _stateController,
                  label: 'State',
                  validatorText: 'Please enter the state'),
              const SizedBox(height: 10),
              _buildTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  validatorText: 'Please enter a description',
                  maxLines: 5),
              const SizedBox(height: 20),
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator(color: Color(0xFFF5A623))
                    : ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF5A623),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text(
                          'Add Destination',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String validatorText,
    int maxLines = 1,
  }) {
    return Container(
      height: maxLines == 1 ? 50 : null,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return validatorText;
          }
          return null;
        },
      ),
    );
  }
}
