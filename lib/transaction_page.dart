import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Дансны хуулга"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(child: Text("Хуулга")),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(child: Text("НӨАТ")),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: summaryCard("Нийт орлого", "+302,000₮", Colors.teal),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child:
                  summaryCard("Нийт зарлага", "-288,091₮", Colors.deepPurple),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: const [
                  Icon(Icons.calendar_month, color: Colors.white),
                  SizedBox(width: 8),
                  Text("2025-11-01 — 2025-11-30"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  txCard("Firebase", "-72,391₮", "2025/11/06 20:23",
                      "Үлдэгдэл: 24,227₮"),
                  txCard("miniapp P2B", "-4,000₮", "2025/11/05 21:52",
                      "Үлдэгдэл: 96,618₮"),
                  txCard("Банк хоорондын шилжүүлэг", "-200₮", "2025/11/05 20:49",
                      "Үлдэгдэл: 100,618₮"),
                  txCard("Нэргүй (5023875028)", "-200,000₮", "2025/11/05 20:49",
                      "Үлдэгдэл: 100,818₮"),
                  txCard("Банкны картаас орлого", "+300,000₮",
                      "2025/11/05 20:48", "Үлдэгдэл: 300,818₮"),
                  txCard("5000 нэгж + 15GB дата", "-10,000₮", "2025/11/04 09:32",
                      "Үлдэгдэл: 819,877₮"),
                  txCard("Store Payment", "-1,500₮", "2025/11/04 09:12",
                      "Үлдэгдэл: 829,877₮"),
                  txCard("Хаан банк орлого", "+200,000₮", "2025/11/03 18:43",
                      "Үлдэгдэл: 1,029,877₮"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryCard(String title, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget txCard(
      String title, String amount, String date, String balanceText) {
    final bool isIncome = amount.startsWith("+");
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(date, style: const TextStyle(color: Colors.white54)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(balanceText,
                  style: const TextStyle(color: Colors.white54)),
              Text(
                amount,
                style: TextStyle(
                  fontSize: 16,
                  color: isIncome ? Colors.greenAccent : Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
