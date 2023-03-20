import 'package:c2c_project1/Services.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:c2c_project1/screens/login_screen.dart';
import 'package:c2c_project1/components/rounded_button.dart';
import 'package:c2c_project1/screens/registration_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home_screen.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted>
    with SingleTickerProviderStateMixin {
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D8FFF),
      // backgroundColor: Colors.green.withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Get Started!',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              SizedBox(
                width: 200.0,
                child: RoundedButton(
                  textColor: Colors.black54,
                  color: Colors.white,
                  title: 'Log in',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                width: 200.0,
                child: RoundedButton(
                  color: Colors.white,
                  title: 'Register',
                  textColor: Colors.black54,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationScreen()),
                    );
                  },
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
              ),
              const Text(
                'Sign Up Using',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () async {
                      try {
                        await GoogleLogin().signInWithGoogle();

                        const secureStorage = FlutterSecureStorage();

                        final User? user = _auth.currentUser;
                        print(user?.email);

                        await secureStorage.write(key: 'uid', value: user?.uid);

                        _firestore
                            .collection("userProfile")
                            .doc(user?.uid)
                            .get()
                            .then((doc) {
                          if (doc.exists) {
                            Navigator.popUntil(context,
                                ModalRoute.withName('/welcome_screen'));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomesPage()),
                            );
                          } else {
                            // Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()),
                            );
                          }
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    child: SizedBox(
                      width: 60.0,
                      height: 60.0,
                      child: Image.asset('images/google.png'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: SizedBox(
                      width: 60.0,
                      height: 60.0,
                      child: Image.asset('images/fb.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
