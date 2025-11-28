import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'help_page.dart';
import 'transaction_page.dart';
import 'gift_page.dart';
import 'contract_page.dart';
import 'Bank_Connect_page.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic>? userData;
  const ProfilePage({super.key, this.userData});

  @override
  Widget build(BuildContext context) {

    final surname = userData?['patronymic'] ?? "";
    final firstLetter = surname.isNotEmpty ? surname[0] : "";
    final firstName = userData?['name'] ?? "";
    final displayName = "$firstLetter.$firstName";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Профайл"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: userData == null
            ? const Center(
          child: Text(
            "Хэрэглэгчийн мэдээлэл олдсонгүй ❌",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        )
            : ListView(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[800],
                  child: const Icon(Icons.person,
                      size: 45, color: Colors.white70),
                ),
                const SizedBox(width: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),

                    Text(
                      "📞 ${userData!['phone']}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      "✉️ ${userData!['email']}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detailItem("Регистрийн дугаар", userData!['regNumber']),
                  _dividerLine(),

                  _detailItem("Төрсөн огноо", userData!['birthDate']),
                  _dividerLine(),

                  _detailItem("Хүйс", userData!['gender']),
                  _dividerLine(),

                  _detailItem("Гэрийн хаяг", userData!['address']),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("MonPay дансны дугаар: 9910 6105 912",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 4),
                  Text("IBAN данс: MN15 0050 0991 0610 5912",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _decoratedMenuItem(
              context,
              icon: Icons.verified_user,
              color: Colors.green,
              title: "Цахим мөнгөний гэрээ",
              page: ContractPage(userData: userData),
            ),

            _decoratedMenuItem(
              context,
              icon: Icons.card_giftcard,
              color: Colors.orange,
              title: "Купон",
              page: const GiftPage(),
            ),

            _decoratedMenuItem(
              context,
              icon: Icons.account_balance,
              color: Colors.purple,
              title: "Бүртгэлтэй банкны данс",
              page: const BankConnectPage(),
            ),

            _decoratedMenuItem(
              context,
              icon: Icons.history,
              color: Colors.blue,
              title: "Дансны хуулга",
              page: const TransactionPage(),
            ),

            _decoratedMenuItem(
              context,
              icon: Icons.description,
              color: Colors.lightBlueAccent,
              title: "Үйлчилгээний нөхцөл",
              onTap: () async {
                await launchUrl(
                  Uri.parse("https://monpay.mn/mn/introduction/terms-and-conditions"),
                  mode: LaunchMode.externalApplication,
                );
              },
            ),

            _decoratedMenuItem(
              context,
              icon: Icons.contact_support,
              color: Colors.cyanAccent,
              title: "Холбоо барих",
              page: const HelpPage(),
            ),

            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  minimumSize: const Size(200, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Гарах",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.3,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              value ?? '-',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dividerLine() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 1,
      color: Colors.white10,
    );
  }

  Widget _decoratedMenuItem(
      BuildContext context, {
        required IconData icon,
        required Color color,
        required String title,
        Widget? page,
        VoidCallback? onTap,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          } else if (page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
