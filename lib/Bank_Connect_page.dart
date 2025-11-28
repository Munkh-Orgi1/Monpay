import 'package:flutter/material.dart';

class BankConnectPage extends StatefulWidget {
  const BankConnectPage({super.key});

  @override
  State<BankConnectPage> createState() => _BankConnectPageState();
}

class _BankConnectPageState extends State<BankConnectPage> {
  String selectedBank = "Банк сонгох";

  final List<Map<String, String>> banks = [
    {"name": "ХААН БАНК", "logo": "assets/khaan.png"},
    {"name": "ГОЛОМТ БАНК", "logo": "assets/golomt.jpg"},
    {"name": "ХУДАЛДАА ХӨГЖЛИЙН БАНК", "logo": "assets/tdb.png"},
    {"name": "ХАС БАНК", "logo": "assets/has.jpg"},
    {"name": "ТӨРИЙН БАНК", "logo": "assets/state.jpg"},
    {"name": "КАПИТРОН БАНК", "logo": "assets/capitron.png"},
  ];

  void _showBankSelectPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Банкны данс холбох",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              ...banks.map((bank) {
                return ListTile(
                  leading: Image.asset(bank["logo"]!, width: 35, height: 35),
                  title: Text(
                    bank["name"]!,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    setState(() {
                      selectedBank = bank["name"]!;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Гарчиг
            const Text(
              "Банкны данс холбох",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            GestureDetector(
              onTap: _showBankSelectPopup,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance, color: Colors.white),
                    const SizedBox(width: 12),
                    Text(
                      selectedBank,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text("Дансны дугаар",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Та энд бичнэ үү",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 30),

            const Text("Данс эзэмшигчийн нэр",
                style: TextStyle(fontSize: 14, color: Colors.grey)),

            const Spacer(),

            const Text(
              "Энэхүү данс нь 20 сая төгрөгөөс дээш дүнтэй урт хугацааны зээл олголт хийгдэхэд ашиглагдана.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Холбох",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
