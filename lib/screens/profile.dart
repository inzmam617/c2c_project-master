import 'package:c2c_project1/components/rounded_button.dart';
import 'package:c2c_project1/screens/home_screen.dart';
import 'package:c2c_project1/screens/storageManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path/path.dart' as path_module;
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' hide Location;

String _userName = "";
String _phone = "";
String uploadProfilePicture = '';
bool showSpinner = false;
late String _profilePictureURL;

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Storage storage = Storage();
  bool _validateUserName = true;
  late bool _validatePhone = true;
  String gender = '';
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  int val = -1;

  late TextEditingController localityController = TextEditingController();
  late TextEditingController postalCodeController = TextEditingController();
  late TextEditingController countryController = TextEditingController();

  Location location = Location();
  late LocationData locationData;
  String _cityLocality = '';
  String _postalCode = '';
  String _country = '';
  bool showSpinner = false;
  String? token;

  bool isDescription = true;
  bool isPrice = true;
  bool isCountry = true;
  bool isCity = true;
  bool isPostalCode = true;

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

  void getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    print('Registration Token=$token');
  }

  @override
  void initState() {
    _validateUserName;
    super.initState();
    getLocationPermission();
    getLocation();
    getToken();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Setup Your Profile'),
        ),
        body: ListView(
          children: [
            FutureBuilder(
              future: storage.downloadUrl(uploadProfilePicture),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  _profilePictureURL = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {},
                      child: ProfilePicture(
                        name: _userName,
                        radius: 100.0,
                        fontsize: 21,
                        img: snapshot.data!,
                      ),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  _profilePictureURL = '';
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {},
                      child: CircleAvatar(
                        radius: 100.0,
                        child: Image.asset('images/profile.png'),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  final uploadImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (uploadImage == null) {
                    setState(() {
                      showSpinner = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No File Selected!'),
                        ),
                      );
                    });
                  } else {
                    final path = uploadImage.path;
                    final fileName =
                        '${user?.email}-${path_module.basename(uploadImage.path)}';

                    storage
                        .uploadFile(path.toString(), fileName.toString())
                        .then((value) => {
                              setState(
                                () {
                                  uploadProfilePicture = fileName.toString();
                                  showSpinner = false;
                                },
                              ),
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile Updated!'),
                                ),
                              ),
                            });
                  }
                },
                child: const Text(
                  'Edit Profile Picture',
                  style: kSendButtonTextStyle,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(9.0),
              child: Text(
                'Set Username: ',
                style: kSendButtonTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  _userName = value;
                  setState(() {
                    _validateUserName;
                  });
                },
                controller: usernameController,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your username',
                  errorText: _validateUserName ? null : 'Value Can\'t Be Empty',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(9.0),
              child: Text(
                'Set Phone Number: ',
                style: kSendButtonTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  _phone = value;
                  setState(() {
                    _validatePhone;
                  });
                },
                controller: phoneController,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your phone number',
                  errorText: _validateUserName ? null : 'Value Can\'t Be Empty',
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Padding(
              padding: EdgeInsets.all(9.0),
              child: Text(
                'Select Gender: ',
                style: kSendButtonTextStyle,
              ),
            ),
            const SizedBox(
              height: 7.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text("Male"),
                  leading: Radio(
                    value: 1,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value as int;
                        gender = 'Male';
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  title: const Text("Female"),
                  leading: Radio(
                    value: 2,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value as int;
                        gender = 'Female';
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                ListTile(
                  title: const Text("Other"),
                  leading: Radio(
                    value: 3,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value as int;
                        gender = 'Other';
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ),
              ],
            ),
            Center(
              child: RoundedButton(
                title: 'Save',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  setState(() {
                    usernameController.text.isEmpty
                        ? _validateUserName = false
                        : _validateUserName = true;

                    phoneController.text.isEmpty
                        ? _validatePhone = false
                        : _validatePhone = true;
                  });
                  if (_validateUserName && _validatePhone) {
                    _firestore.collection('userProfile').doc(user?.uid).set({
                      'username': _userName,
                      'uid': user?.uid,
                      'email': user?.email,
                      'profilePicture': _profilePictureURL,
                      'time': FieldValue.serverTimestamp(),
                      'phone': _phone,
                      'gender': gender,
                      'chattingWith': null,
                      'token': token,
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
                    Navigator.popUntil(
                        context, ModalRoute.withName('/welcome_screen'));
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomesPage()),
                    );
                  }
                },
                textColor: Colors.white,
                fontSize: kFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
