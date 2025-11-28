import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPRegisterPage extends StatefulWidget {
  const OTPRegisterPage({super.key});

  @override
  State<OTPRegisterPage> createState() => _OTPRegisterPageState();
}

class _OTPRegisterPageState extends State<OTPRegisterPage> {
  final phoneCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  String verificationId = '';
  bool otpSent = false;

  Future<void> sendCode() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+976${phoneCtrl.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Алдаа: ${e.message}')));
      },
      codeSent: (verId, resendToken) {
        setState(() {
          verificationId = verId;
          otpSent = true;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('OTP код илгээгдлээ ✅')));
      },
      codeAutoRetrievalTimeout: (verId) {
        verificationId = verId;
      },
    );
  }

  Future<void> verifyCode() async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpCtrl.text.trim());
      await FirebaseAuth.instance.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP баталгаажлаа ✅')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Буруу OTP код ❌')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP бүртгэл")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: otpSent
            ? Column(
          children: [
            const Text("OTP код оруулна уу:"),
            TextField(
              controller: otpCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "OTP код"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: verifyCode, child: const Text("Баталгаажуулах")),
          ],
        )
            : Column(
          children: [
            const Text("Утасны дугаар оруулна уу:"),
            TextField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration:
              const InputDecoration(labelText: "Утасны дугаар"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: sendCode, child: const Text("Код илгээх")),
          ],
        ),
      ),
    );
  }
}
