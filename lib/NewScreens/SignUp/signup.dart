import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:location/location.dart';
import '../../Services.dart';
import '../../screens/home_screen.dart';
import '../../screens/profile.dart';
import '../SignIn/SignIn.dart';


class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {


  @override
  void initState() {
    // _validateUserName;
    super.initState();
    getLocationPermission();
    getLocation();
    // getToken();
  }
  late LocationData locationData;
  String _cityLocality = '';
  String _postalCode = '';
  String _country = '';
  bool showSpinner = false;


  Location location = Location();
  void getLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Location Service Not Enabled!"),
            content: const Text("You have raised a Alert Dialog Box"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Location Permission Not Granted"),
            content: const Text("You have raised a Alert Dialog Box"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      }
    }
  }

  void getLocation() async {
    try {
      locationData = await location.getLocation();

      double? lat = locationData.latitude;
      double? long = locationData.longitude;
      List<Placemark> placeMark = await placemarkFromCoordinates(lat!, long!);

      Placemark place = placeMark[0];

      _cityLocality = '${place.locality}';
      _postalCode = '${place.postalCode}';
      _country = '${place.country}';
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
  // const signup({Key? key}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;

  late String email;
  late String name;
  late String password;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(children: [
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
                      "Sign Up",
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
                onChanged: (value) {
                  name = value;
                },
                cursorWidth: 0.5,
                cursorColor: Colors.black,
                style: const TextStyle(color: Color(0xffC0BDBD)),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 18),
                    prefixIcon: SvgPicture.asset(
                      "assets/Iconly-Bulk-Profile.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: "Name",
                    hintStyle: const TextStyle(color: Color(0xffC0BDBD),fontSize: 12),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.25,
              child: TextFormField(
                onChanged: (value) {
                  email = value;
                },
                cursorWidth: 0.5,
                cursorColor: Colors.black,
                style: const TextStyle(color: Color(0xffC0BDBD),fontSize: 12),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 18),
                    prefixIcon: SvgPicture.asset(
                      "assets/Iconly-Bulk-Message.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: "Email",
                    hintStyle: const TextStyle(color: Color(0xffC0BDBD)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.25,
              child: TextFormField(

                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                cursorWidth: 0.5,
                cursorColor: Colors.black,
                style: const TextStyle(color: Color(0xffC0BDBD),fontSize: 12),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 18),
                    prefixIcon: SvgPicture.asset(
                      "assets/Iconly-Bulk-Unlock.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: "Password",
                    hintStyle: const TextStyle(color: Color(0xffC0BDBD)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.25,
              child: TextFormField(
                cursorWidth: 0.5,
                cursorColor: Colors.black,
                style: const TextStyle(color: Color(0xffC0BDBD),fontSize: 12),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 18),
                    prefixIcon: SvgPicture.asset(
                      "assets/Iconly-Bulk-Lock.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: "Confirm Password",
                    hintStyle: const TextStyle(color: Color(0xffC0BDBD),fontSize: 12),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
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
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);

                      setState(() {
                        _firestore.collection('userProfile').doc(_auth.currentUser?.uid).set({
                          'username': name,
                          'uid': _auth.currentUser?.uid,
                          'email': _auth.currentUser?.email,
                          "savedPosts" : FieldValue.arrayUnion([0]),

                          // 'username': firstName,
                          "lastname" : "No Last Yet",
                          // 'profilePicture': editProfile,
                          // "email" : Email,
                          "Phone" : "No Phone Yet",
                          // 'profilePicture': _profilePictureURL,
                          'time': FieldValue.serverTimestamp(),
                          // 'phone': _phone,
                          // 'gender': gender,
                          'chattingWith': null,
                          // 'token': token,
                          'address': '$_cityLocality, $_postalCode, $_country',
                          'rating': {
                            '1': {'0': 0},
                            '2': {'0': 0},
                            '3': {'0': 0},
                            '4': {'0': 0},
                            '5': {'0': 0},
                          },
                          'status': '',
                        });
                        // showSpinner = false;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignIn()),
                        );
                      });
                      showSpinner = false;
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar( content: Text(e.toString())),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFD8A00),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32)))),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 12, fontFamily: "Poppins", color: Colors.white),
                  )),
            ),
            const SizedBox(height: 30),
            const Text(
              "OR",
              style: TextStyle(fontSize: 12, fontFamily: "SF Pro Text"),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
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
                  child: SvgPicture.asset("assets/Group 1788.svg",
                      height: 50, width: 50),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset("assets/facebook.svg",
                    height: 50, width: 50),
                const SizedBox(width: 10),
                SvgPicture.asset("assets/apple.svg", height: 50, width: 50),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Don't have an Account? ",
                    style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                  ),
                ),
                TextButton(
                  child: const Text(
                    "Signin",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Poppins",
                        color: Color(0xffFD8A00)),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const SignIn();
                    }));
                  },
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
