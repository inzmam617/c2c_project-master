import 'dart:async';

import 'package:c2c_project1/screens/home_screen.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  getNextPage() {
    return FirebaseFirestore.instance
        .collection("userProfile")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((doc) {
      if (doc.exists) {
        Navigator.popUntil(context, ModalRoute.withName('/welcome_screen'));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomesPage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
      }
    });
  }

  saveUser() async {
    const secureStorage = FlutterSecureStorage();

    final User? user = FirebaseAuth.instance.currentUser;

    await secureStorage.write(key: 'uid', value: user?.uid);
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = (FirebaseAuth.instance.currentUser?.emailVerified)!;
      saveUser();
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  initState() {
    super.initState();
    isEmailVerified = (FirebaseAuth.instance.currentUser?.emailVerified)!;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? getNextPage()
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Verify Your Email'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Card(
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'Hey! We\'ve sent you an verification mail. Please go and verify your account.'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('\nMake sure to check the spam folder!'),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text('Resend Email'),
                  onPressed: () {
                    sendVerificationEmail();
                  },
                ),
              ],
            ),
          );
  }
}
