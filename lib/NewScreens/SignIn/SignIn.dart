import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../HomePages/Home.dart';
import '../SignUp/signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  bool isPasswordVisible = false;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.25,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Center(
                            child: Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: SvgPicture.asset("assets/Fashion blogging-amico.svg"),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(top: 280),
                          child: Align(
                              alignment: Alignment.topRight,
                              child:
                                  SvgPicture.asset("assets/design colors.svg")),
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 350),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: "Poppins",
                                  color: Color(0xff1A1D3A),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,

                        onChanged: (value) {
                          email = value;
                        },
                        cursorColor: Colors.black,
                        cursorWidth: 0.5,
                        style: const TextStyle(color: Color(0xffC0BDBD)),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 14),
                            prefixIcon: SvgPicture.asset(
                              "assets/Iconly-Bulk-Message.svg",
                              fit: BoxFit.scaleDown,
                            ),
                            hintText: "Email",
                            hintStyle:
                            const TextStyle(color: Color(0xffC0BDBD), fontSize: 12),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.25,
                      child: TextFormField(
                        onChanged: (value) {
                          password = value;
                        },
                        cursorColor: Colors.black,
                        cursorWidth: 0.5,
                        style: const TextStyle(color: Color(0xffC0BDBD)),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 15),
                            prefixIcon: SvgPicture.asset(
                              "assets/Iconly-Bulk-Lock.svg",
                              fit: BoxFit.scaleDown,
                            ),
                            suffixIcon: SvgPicture.asset(
                              "assets/Show.svg",
                              fit: BoxFit.scaleDown,
                            ),
                            hintText: "Password",
                            hintStyle:
                            const TextStyle(color: Color(0xffC0BDBD), fontSize: 12),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: "Poopins",
                            color: Color(0xffFD8A00)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
              SizedBox(
                width: 195,
                height: 35,
                child: ElevatedButton(
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
                          // if (doc.exists) {
                            Navigator.popUntil(context,
                                ModalRoute.withName('/welcome_screen'));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          // }
                          // else {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const Profile()),
                          //   );
                          // }
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
                    // onPressed: () {
                    //   Navigator.of(context).push(
                    //       MaterialPageRoute(builder: (BuildContext context) {
                    //     return HomePage();
                    //   }));
                    // },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFD8A00),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32)))),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Poppins",
                          color: Colors.white),
                    )),
              ),
              const SizedBox(height: 30),
              const Text(
                "OR",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "SF Pro Text",
                    color: Color(0xff200A4D)),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/Group 1788.svg",
                      height: 50, width: 50),
                  const SizedBox(width: 10),
                  SvgPicture.asset("assets/facebook.svg",
                      height: 50, width: 50),
                  const SizedBox(width: 10),
                  SvgPicture.asset("assets/apple.svg", height: 50, width: 50),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an Account? ",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      "Signup",
                      style: TextStyle(fontSize: 12, color: Color(0xffFD8A00)),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return  const signup();
                      }));
                    },
                  )
                ],
              )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center
              //   ,crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Text("Dont't have an Account?"),
              //     TextButton(onPressed: (){}, child: const Text("ASd"))
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
