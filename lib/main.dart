import 'package:flutter/material.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'help_page.dart';
import 'transaction_page.dart';
import 'gift_page.dart';
import 'contract_page.dart';
import 'register_page.dart';
import 'otp_register_page.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MonPay Clone",
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.blue,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const LoginPage(),
    );
  }
}
