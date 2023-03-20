import 'package:c2c_project1/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/onSaleLayout.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import 'package:geocoding/geocoding.dart' hide Location;

String userAddress = '';
String _address = '';
bool _validatePrice = true;

class EditProductDescription extends StatefulWidget {
  const EditProductDescription(
      {Key? key,
      required this.editDescription,
      required this.editPrice,
      required this.editAddress})
      : super(key: key);

  final String editDescription;
  final int editPrice;
  final String editAddress;

  @override
  State<EditProductDescription> createState() => _EditProductDescriptionState();
}

class _EditProductDescriptionState extends State<EditProductDescription> {
  TextEditingController priceController = TextEditingController();
  late TextEditingController localityController = TextEditingController();
  late TextEditingController postalCodeController = TextEditingController();
  late TextEditingController countryController = TextEditingController();

  Location location = Location();
  late LocationData locationData;
  String _cityLocality = '';
  String _postalCode = '';
  String _country = '';
  bool showSpinner = false;

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
    _validatePrice;
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
    localityController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

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
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.editDescription,
                    maxLength: 100,
                    maxLines: 3,
                    decoration: kPostTextFieldDecoration.copyWith(
                      labelText: 'Add Description',
                      hintText:
                          'Add more about the product! It is a pro technique to sell products quickly.',
                    ),
                    onChanged: (value) {
                      editDescription = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Current Price: ${widget.editPrice}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: kPostTextFieldDecoration.copyWith(
                      labelText: 'Price',
                      hintText: 'Set New Price',
                      errorText: _validatePrice
                          ? null
                          : 'Price cannot be less than \$10',
                    ),
                    onChanged: (value) {
                      editPrice = int.parse(value);
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Current Address: ${widget.editAddress}'),
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
                                      TextEditingController(text: _postalCode);
                                  countryController =
                                      TextEditingController(text: _country);
                                });
                                userAddress = _address;
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
                              if (priceController.text.isNotEmpty &&
                                  editPrice >= 10) {
                                _validatePrice = true;
                              } else {
                                _validatePrice = false;
                              }
                              showSpinner = true;
                            });
                            if (_validatePrice) {
                              userAddress =
                                  '$_cityLocality, $_postalCode, $_country';
                              setState(() {
                                editAddress = userAddress;
                              });
                              // print(userAddress);
                              print(editDraftID);
                              firestore
                                  .collection('Posts')
                                  .doc(editDraftID)
                                  .update({
                                'title': editTitle,
                                'productCategory': editCategory,
                                'materialCondition': editCondition,
                                'brand': editBrand,
                                'images': editImages,
                                'fabric': editFabric,
                                'pattern': editPattern,
                                'color': editColor,
                                'description': editDescription,
                                'cost': editPrice,
                                'postedBy': user?.email,
                                'uID': user?.uid,
                                'address': editAddress,
                                'onSale': true,
                                'views': 0,
                                'archive': 'no',
                              });
                              setState(() {
                                showSpinner = false;
                                Navigator.popUntil(
                                  context,
                                  ModalRoute.withName('/home_screen'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Posted Successfully'),
                                ));
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
