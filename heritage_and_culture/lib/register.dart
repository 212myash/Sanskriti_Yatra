import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? dob;
  String? gender;
  bool agreeToTerms = false;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    String name = nameController.text.trim();
    String userName = userNameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (name.isEmpty ||
        userName.isEmpty ||
        phone.isEmpty ||
        dob == null ||
        gender == null ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showMessage("All fields are required!", Colors.red);
      return;
    }

    if (password.length < 6) {
      showMessage("Password must be at least 6 characters!", Colors.red);
      return;
    }

    if (password != confirmPassword) {
      showMessage("Passwords do not match!", Colors.red);
      return;
    }

    if (!agreeToTerms) {
      showMessage("You must agree to the terms!", Colors.red);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      var response = await http
          .post(
            ApiConfig.uri('/api/users/register'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "name": name,
              "user_name": userName,
              "phone": phone,
              "dob": dob,
              "gender": gender,
              "password": password,
            }),
          )
          .timeout(ApiConfig.requestTimeout);

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showMessage("Sign-Up Successful!", Colors.green);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        var errorMessage = "Error";
        try {
          final decoded = jsonDecode(response.body);
          if (decoded is Map<String, dynamic>) {
            errorMessage = decoded['message']?.toString() ?? errorMessage;
          }
        } catch (_) {}
        showMessage("Signup Failed: $errorMessage", Colors.red);
      }
    } catch (e) {
      if (!mounted) return;
      showMessage("Error: $e", Colors.red);
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dob =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/icon/heritage.png',
                    height: 130,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Sign Up !",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD88A26),
                  ),
                ),
                const SizedBox(height: 5),
                buildTextField(nameController, "NAME"),
                const SizedBox(height: 5),
                buildTextField(userNameController, "USERNAME"),
                const SizedBox(height: 5),
                buildTextField(phoneController, "PHONE NO."),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: buildTextField(
                        TextEditingController(text: dob), "DATE OF BIRTH"),
                  ),
                ),
                const SizedBox(height: 5),

                // Gender Dropdown
                Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: gender,
                      hint: const Text("SELECT GENDER"),
                      isExpanded: true,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      items: const [
                        DropdownMenuItem(value: "Male", child: Text("Male")),
                        DropdownMenuItem(
                            value: "Female", child: Text("Female")),
                        DropdownMenuItem(value: "Other", child: Text("Other")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 5),
                buildTextField(passwordController, "PASSWORD",
                    obscureText: true),
                const SizedBox(height: 5),
                buildTextField(confirmPasswordController, "CONFIRM PASSWORD",
                    obscureText: true),
                const SizedBox(height: 5),

                // Terms & Conditions Checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          agreeToTerms = value!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        "I agree with the Terms of Service",
                        style: TextStyle(fontSize: 14),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD88A26),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isLoading ? null : signUp,
                    child: isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text("Sign Up",
                            style: TextStyle(color: Colors.white)),
                  ),
                ),

                // Already have an account? Sign In
                const SizedBox(height: 10),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Color(0xFFD88A26)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label,
      {bool obscureText = false}) {
    return SizedBox(
      height: 45,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        ),
      ),
    );
  }
}
