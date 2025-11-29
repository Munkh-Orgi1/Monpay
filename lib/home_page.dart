import 'package:flutter/material.dart';

import 'gift_page.dart';
import 'help_page.dart';
import 'profile_page.dart';
import 'transaction_page.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const HomePage({super.key, required this.userData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      ProfilePage(userData: widget.userData),
      const TransactionPage(),
      const GiftPage(),
      const HelpPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профайл',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Гүйлгээ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Купон',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Тусламж',
          ),
        ],
      ),
    );
  }
}
