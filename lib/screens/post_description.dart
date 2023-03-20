import 'package:c2c_project1/screens/post_detailing.dart';
import 'package:c2c_project1/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/rounded_button.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:path/path.dart' as path;
import 'post_screen.dart';

class ProductDescriptionPage extends StatefulWidget {
  const ProductDescriptionPage({Key? key}) : super(key: key);

  @override
  State<ProductDescriptionPage> createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  late TextEditingController localityController = TextEditingController();
  late TextEditingController postalCodeController = TextEditingController();
  late TextEditingController countryController = TextEditingController();

  Location location = Location();
  late LocationData locationData;
  String _cityLocality = '';
  String _postalCode = '';
  String _country = '';
  bool showSpinner = false;

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

      // _address =
      //     '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

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

  @override
  void initState() {
    isPrice;
    super.initState();
    getLocation();

    localityController;
    postalCodeController;
    countryController;
  }

  @override
  void dispose() {
    super.dispose();
    priceController.dispose();
    descController.dispose();
    localityController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    String address = '';

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Post'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: descController,
                      maxLength: 256,
                      maxLines: 3,
                      decoration: kPostTextFieldDecoration.copyWith(
                        labelText: 'Add Description',
                        hintText:
                            'Add details on the product you are posting. Example: I worn it on my wedding...',
                        errorText:
                            isDescription ? null : 'Field Cannot Be Left Empty',
                      ),
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLength: 8,
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: kPostTextFieldDecoration.copyWith(
                        labelText: 'Price',
                        hintText: 'Set Price',
                        counterText: '',
                        errorText: isPrice
                            ? null
                            : (priceController.text.isEmpty
                                ? 'Field Cannot Be Left Empty'
                                : 'Price cannot be less than \$10'),
                      ),
                      onChanged: (value) {
                        productPrice = int.parse(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Add Your Address:',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: localityController,
                                keyboardType: TextInputType.text,
                                decoration: kPostTextFieldDecoration.copyWith(
                                  labelText: 'City/Locality',
                                  hintText: 'Mountain View',
                                  errorText: isCity
                                      ? null
                                      : 'Field Cannot Be Left Empty',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _cityLocality = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: postalCodeController,
                                keyboardType: TextInputType.text,
                                decoration: kPostTextFieldDecoration.copyWith(
                                  labelText: 'Postal Code',
                                  hintText: '12345',
                                  errorText: isPostalCode
                                      ? null
                                      : 'Field Cannot Be Left Empty',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _postalCode = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: countryController,
                                keyboardType: TextInputType.text,
                                decoration: kPostTextFieldDecoration.copyWith(
                                  labelText: 'Country',
                                  hintText: 'USA',
                                  errorText: isCountry
                                      ? null
                                      : 'Field Cannot Be Left Empty',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _country = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Set Location"),
                            content: const Text(
                                "Continue With Your Current Location. You can edit it manually if you want!"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  getLocationPermission();
                                  getLocation();
                                  setState(() {
                                    localityController = TextEditingController(
                                        text: _cityLocality);
                                    postalCodeController =
                                        TextEditingController(
                                            text: _postalCode);
                                    countryController =
                                        TextEditingController(text: _country);
                                  });
                                  userAddress = address;
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("Okay"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("Enter Manually"),
                              ),
                            ],
                          ),
                        );
                      });
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.my_location,
                          size: 35.0,
                          color: Colors.lightBlueAccent,
                        ),
                        Text(
                          ' Get My Current Location',
                          style: kSendButtonTextStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: RoundedButton(
                            title: 'Post Product',
                            color: Colors.lightBlueAccent,
                            onPressed: () async {
                              setState(() {
                                if (descController.text.isEmpty) {
                                  isDescription = false;
                                } else {
                                  isDescription = true;
                                }
                                if (localityController.text.isEmpty) {
                                  isCity = false;
                                } else {
                                  isCity = true;
                                }
                                if (postalCodeController.text.isEmpty) {
                                  isPostalCode = false;
                                } else {
                                  isPostalCode = true;
                                }
                                if (countryController.text.isEmpty) {
                                  isCountry = false;
                                } else {
                                  isCountry = true;
                                }
                                if (priceController.text.isNotEmpty &&
                                    productPrice >= 10) {
                                  isPrice = true;
                                } else {
                                  isPrice = false;
                                }

                                showSpinner = true;
                              });
                              if (isPrice &&
                                  isDescription &&
                                  isCity &&
                                  isPostalCode &&
                                  isCountry) {
                                imagesToBePosted.insert(0, uploadedFile);
                                for (var img in imagesToBePosted) {
                                  var ref = FirebaseStorage.instance.ref().child(
                                      '${user?.email}/${path.basename(img.path)}');
                                  await ref.putFile(img).whenComplete(() async {
                                    await ref.getDownloadURL().then((value) {
                                      imgRef.add(value);
                                    });
                                  });
                                }
                                userAddress =
                                    '$_cityLocality, $_postalCode, $_country';
                                // print(userAddress);
                                firestore.collection('Posts').add({
                                  'title': productTitle,
                                  'productCategory': productCategory,
                                  'materialCondition': materialCondition,
                                  'brand': productBrand,
                                  'images': imgRef,
                                  'fabric': productFabric,
                                  'pattern': productPattern,
                                  'occasion': productOccasion,
                                  'size': productSize,
                                  'color': productColor,
                                  'description': description,
                                  'cost': productPrice,
                                  'postedBy': user?.email,
                                  'uID': user?.uid,
                                  'address': userAddress,
                                  'onSale': true,
                                  'views': 0,
                                  'time': FieldValue.serverTimestamp(),
                                  'archive': 'no',
                                });
                                setState(() {
                                  showSpinner = false;
                                  imgRef = [];
                                  Navigator.popUntil(
                                    context,
                                    ModalRoute.withName('/home_screen'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Posted Successfully'),
                                  ));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomesPage()),
                                  );
                                });
                              } else {
                                setState(() {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Please check if you have filled all the details properly!'),
                                  ));
                                  showSpinner = false;
                                });
                              }
                            },
                            textColor: Colors.white,
                            fontSize: kFontSize,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: RoundedButton(
                            title: 'Save as Draft',
                            color: Colors.white,
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              imagesToBePosted.insert(0, uploadedFile);
                              for (var img in imagesToBePosted) {
                                var ref = FirebaseStorage.instance.ref().child(
                                    '${user?.email}/${path.basename(img.path)}');
                                await ref.putFile(img).whenComplete(() async {
                                  await ref.getDownloadURL().then((value) {
                                    imgRef.add(value);
                                  });
                                });
                              }
                              userAddress =
                                  '$_cityLocality, $_postalCode, $_country';

                              firestore
                                  .collection('Drafts')
                                  .doc(user?.uid)
                                  .collection('Products')
                                  .add({
                                'title': productTitle,
                                'productCategory': productCategory,
                                'materialCondition': materialCondition,
                                'brand': productBrand,
                                'images': imgRef,
                                'fabric': productFabric,
                                'pattern': productPattern,
                                'occasion': productOccasion,
                                'size': productSize,
                                'color': productColor,
                                'description': description,
                                'cost': productPrice,
                                'postedBy': user?.email,
                                'uID': user?.uid,
                                'address': userAddress,
                                'onSale': true,
                                'views': 0,
                                'time': FieldValue.serverTimestamp(),
                                'archive': 'no',
                              });
                              setState(() {
                                imgRef = [];
                                Navigator.popUntil(
                                  context,
                                  ModalRoute.withName('/home_screen'),
                                );
                                setState(() {
                                  showSpinner = true;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Saved as Draft!'),
                                ));
                              });
                            },
                            textColor: Colors.lightBlueAccent,
                            fontSize: kFontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
