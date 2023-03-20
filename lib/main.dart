import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'NewScreens/HomePages/Home.dart';
import 'NewScreens/SliderPages/SliderPages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const Project1());
}

class Project1 extends StatelessWidget {
  const Project1({Key? key}) : super(key: key);

  final secureStorage = const FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await secureStorage.read(key: 'uid');

    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: checkLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == false) {
            return const SliderPages();
            // return const WelcomeScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Colors.white, child: const CircularProgressIndicator());
          }
          return const HomePage();
        },
      ),
    );
  }
}
