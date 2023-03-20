import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:c2c_project1/components/rounded_button.dart';
import 'package:c2c_project1/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:c2c_project1/constants.dart';
import 'package:flutter/material.dart';

import '../Services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  bool isPasswordVisible = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Log In',
                  style: TextStyle(
                      color: Color(0xFF5D8FFF),
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Email',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10, 10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 3.0),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10, 10)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10, 10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 3.0),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10, 10)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                SizedBox(
                  width: 300.0,
                  child: RoundedButton(
                    title: 'Login',
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        const secureStorage = FlutterSecureStorage();

                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);

                        final User? user = _auth.currentUser;

                        await secureStorage.write(key: 'uid', value: user?.uid);

                        _firestore
                            .collection("userProfile")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()),
                            );
                          }
                        });

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      }
                    },
                    fontSize: kFontSize,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.2,
                ),
                const Text(
                  'Log In Using',
                  style: TextStyle(
                      color: Color(0xFF5D8FFF),
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

                          await secureStorage.write(
                              key: 'uid', value: user?.uid);

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
      ),
    );
  }
}
