import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<List<Map<String, dynamic>>> _readUsers() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/users.txt');

    if (!await file.exists()) return [];

    final lines = await file.readAsLines();

    return lines.map((line) {
      try {
        final decoded = jsonDecode(line);
        return Map<String, dynamic>.from(decoded);
      } catch (e) {
        return <String, dynamic>{};
      }
    }).toList();
  }

  Future<void> _loginUser() async {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Дугаар болон нууц үгээ оруулна уу!')));
      return;
    }

    final users = await _readUsers();

    final user = users.firstWhere(
          (u) => u['phone'] == phone && u['password'] == password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Нэвтрэлт амжилттай 🎉')));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userData: user),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Утас эсвэл нууц үг буруу байна')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                const Text(
                  "MonPay-д тавтай морил",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Та нэвтрэх утасны дугаар болон нууц үгээ оруулна уу.",
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 25),

                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixText: "+976 ",
                    labelText: "Утасны дугаар",
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Нууц үг",
                    labelStyle: const TextStyle(color: Colors.white70),
                    suffixIcon: const Icon(Icons.visibility_off,
                        color: Colors.white54),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "Нэвтрэх",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // === Register text ===
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      "Хэрэв та бүртгэлгүй бол Бүртгүүлэх",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
