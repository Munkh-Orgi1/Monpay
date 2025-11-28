import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> data = {};
  final phoneCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  String verificationId = "";
  bool otpSent = false;
  bool verified = false;

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/users.txt');
  }

  Future<void> _saveUser() async {
    final file = await _getFile();
    await file.writeAsString(jsonEncode(data) + '\n',
        mode: FileMode.append, flush: true);
  }

  Future<void> sendOTP() async {
    if (Firebase.apps.isEmpty) await Firebase.initializeApp();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+976${phoneCtrl.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Алдаа: ${e.message}')));
      },
      codeSent: (String verId, int? resendToken) {
        setState(() {
          verificationId = verId;
          otpSent = true;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('OTP код илгээгдлээ')));
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  Future<void> verifyOTP() async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCtrl.text.trim(),
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() => verified = true);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP баталгаажлаа')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP код буруу байна')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Бүртгэл үүсгэх')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _textField('Ургийн овог', 'surname'),
            _textField('Овог', 'patronymic'),
            _textField('Өөрийн нэр', 'name'),
            _textField('Регистрийн дугаар', 'regNumber'),
            _textField('Төрсөн огноо', 'birthDate'),
            _textField('Хүйс', 'gender'),
            _textField('И-мэйл', 'email'),
            _textField('Гэрийн хаяг', 'address'),
            const SizedBox(height: 10),

            TextFormField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Нууц үг үүсгэх'),
              validator: (v) =>
              v!.length < 4 ? "Нууц үг 4 тэмдэгтээс дээш байх ёстой" : null,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Утасны дугаар'),
            ),

            const SizedBox(height: 20),

            if (!otpSent)
              ElevatedButton(
                onPressed: sendOTP,
                child: const Text('OTP код илгээх'),
              )
            else if (!verified)
              Column(
                children: [
                  TextField(
                    controller: otpCtrl,
                    keyboardType: TextInputType.number,
                    decoration:
                    const InputDecoration(labelText: 'OTP код оруулах'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: verifyOTP, child: const Text('Баталгаажуулах')),
                ],
              )
            else
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  _formKey.currentState!.save();
                  data['phone'] = phoneCtrl.text;
                  data['password'] = passwordCtrl.text;

                  _saveUser();

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Бүртгэл хадгалагдлаа')));

                  Navigator.pop(context);
                },
                child: const Text('Бүртгэл хадгалах'),
              ),
          ],
        ),
      ),
    );
  }

  TextFormField _textField(String label, String key) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onSaved: (v) => data[key] = v ?? '',
    );
  }
}
