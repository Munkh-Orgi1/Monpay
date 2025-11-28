import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  Future<void> sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'supportwebcom@mobicom.mn',
      query: 'subject=Тусламжийн хүсэлт&body=Сайн байна уу?',
    );

    if (!await launchUrl(emailUri)) {
      throw Exception("Email app нээгдэхгүй байна");
    }
  }

  Future<void> callNumber() async {
    final Uri telUri = Uri(scheme: 'tel', path: '1800-1199');

    if (!await launchUrl(telUri)) {
      throw Exception("Утасны app нээгдэхгүй байна");
    }
  }

  Future<void> openSupportWeb() async {
    await launchUrl(
      Uri.parse("https://support.mobicom.mn/120680-monpay"),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> openFAQWeb() async {
    await launchUrl(
      Uri.parse("https://www.monpay.mn/mn/faq-2"),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> openFacebook() async {
    await launchUrl(
      Uri.parse("https://m.facebook.com/@Monpay.official"),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> openInstagram() async {
    await launchUrl(
      Uri.parse("https://www.instagram.com/monpay.official/"),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> openTwitter() async {
    await launchUrl(
      Uri.parse("https://x.com/MonpayOfficial"),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> openYoutube() async {
    await launchUrl(
      Uri.parse("https://m.youtube.com/user/CandyMongolia"),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> openWebsite() async {
    await launchUrl(
      Uri.parse("https://www.monpay.mn/mn"),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Тусламж"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                helpButton(
                  Icons.question_answer,
                  "Түгээмэл асуулт,\nхариулт",
                  openFAQWeb,
                ),
                helpButton(
                  Icons.help_outline,
                  "Танд тусалъя",
                  openSupportWeb,
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "И-Мэйл хаяг:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    "supportwebcom@mobicom.mn",
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),

                SizedBox(
                  width: 170,
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: sendEmail,
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    label: const Text(
                      "Хүсэлт илгээх",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Холбоо барих дугаар:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    "1800-1199",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 10),

                SizedBox(
                  width: 170,
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: callNumber,
                    icon: const Icon(Icons.call, color: Colors.white, size: 20),
                    label: const Text(
                      "Шууд залгах",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Хаяг, байршил:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            const Text(
              "Монгол Улс, Улаанбаатар хот, Сүхбаатар дүүрэг, "
                  "1-р хороо, Юнескогийн гудамж-28, MPM цогцолбор",
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: const Icon(Icons.facebook,
                        color: Colors.blue, size: 30),
                    onPressed: openFacebook),
                IconButton(
                    icon: const Icon(Icons.camera_alt,
                        color: Colors.pinkAccent, size: 30),
                    onPressed: openInstagram),
                IconButton(
                    icon: const Icon(Icons.chat,
                        color: Colors.lightBlueAccent, size: 30),
                    onPressed: openTwitter),
                IconButton(
                    icon: const Icon(Icons.play_circle_fill,
                        color: Colors.red, size: 30),
                    onPressed: openYoutube),
                IconButton(
                    icon: const Icon(Icons.language,
                        color: Colors.lightBlueAccent, size: 30),
                    onPressed: openWebsite),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget helpButton(IconData icon, String title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 164,
        height: 95,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blueAccent, size: 28),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
