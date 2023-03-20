import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:c2c_project1/NewScreens/Post/PostPage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart' as path;
import '../HomePages/Home.dart';
// import '../../screens/post_screen.dart';

List<File> imagesToBePosted = [];

class PostProductDetails extends StatefulWidget {
  const PostProductDetails({Key? key}) : super(key: key);

  @override
  State<PostProductDetails> createState() => _PostProductDetailsState();
}

class _PostProductDetailsState extends State<PostProductDetails> {
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController fabricController = TextEditingController();
  TextEditingController localityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  bool isDescription = true;
  bool isPrice = true;
  bool isCountry = true;
  bool isCity = true;
  bool isPostalCode = true;
 var documentId  = "";
  int productPrice = 0;
  final _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  // final User? user = _auth.currentUser;
  final firestore = FirebaseFirestore.instance;
  bool showSpinner = false;
  bool uploading = false;
  final List<File> _image = [];
  int counter = 0;
  // Location location = Location();
  // late LocationData locationData;
  final String _cityLocality = '';
  final String _postalCode = '';
  final String _country = '';
  // bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();

  bool selectedblack = false;
  bool selectedblue = false;
  bool selectedred = false;
  bool selectedpurple = false;
  bool selectedbrown = false;
  bool selecteddarkblue = false;

  bool xs = true;
  bool s = false;
  bool m = false;
  bool l = false;
  bool xl = false;

  String size = "";
  String color = "";
  String Scolor = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Post Product",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ModalProgressHUD(

        color: Colors.white,
        inAsyncCall: showSpinner,

        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Specify Details",
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        validator: validator,
                        maxLength: 8,
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
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
                        // decoration: InputDecoration(hintText: "Price"),
                        // controller: priceController,
                      ),
                      TextFormField(
                        validator: validator,
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: "Product Name",
                        ),
                      ),
                      TextFormField(
                        validator: validator,
                        controller: categoryController,
                        decoration: InputDecoration(
                            hintText: "Product Category",
                            suffixIcon: Transform.rotate(
                                angle: 180 * math.pi / 180,
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.black,
                                ))),
                      ),
                      TextFormField(
                        validator: validator,
                        controller: conditionController,
                        decoration: InputDecoration(
                            hintText: "Material Condition",
                            suffixIcon: Transform.rotate(
                                angle: 180 * math.pi / 180,
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.black,
                                ))),
                      ),
                      TextFormField(
                        validator: validator,
                        controller: fabricController,
                        decoration: InputDecoration(
                            hintText: "Fabric",
                            suffixIcon: Transform.rotate(
                                angle: 180 * math.pi / 180,
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.black,
                                ))),
                      ),
                      const Padding(

                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Colors",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 2.0)
                            ]),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedblack = !selectedblack;
                                    selectedblue = true;
                                    selectedred = true;
                                    selectedbrown = true;
                                    selectedpurple = true;
                                    selecteddarkblue = true;
                                  });
                                  setState(() {

                                      color = "black";


                                  });
                                  print(color);
                                },
                                child: selectedblack
                                    ? Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.red),
                                            //color: Colors.blueGrey,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(100))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.5),
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: const BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100))),
                                          ),
                                        ),
                                      ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedblue = !selectedblue;
                                    selectedblack = true;
                                    selectedred = true;
                                    selectedbrown = true;
                                    selectedpurple = true;
                                    selecteddarkblue = true;
                                  });
                                  setState(() {

                                    color = "blue";


                                  });
                                  print(color);
                                },
                                child: selectedblue
                                    ? Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                            color: Color(0xff97AABD),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.red),
                                            //color: Colors.blueGrey,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(100))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.5),
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: const BoxDecoration(
                                                color: Color(0xff97AABD),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100))),
                                          ),
                                        ),
                                      ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedred = !selectedred;
                                    selectedblue = true;
                                    selectedblack = true;
                                    selectedbrown = true;
                                    selectedpurple = true;
                                    selecteddarkblue = true;
                                  });
                                  setState(() {

                                    color = "red";


                                  });
                                  print(color);
                                },
                                child: selectedred
                                    ? Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffB82222),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.red),
                                            //color: Colors.blueGrey,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(100))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.5),
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: const BoxDecoration(
                                                color: Color(0xffB82222),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100))),
                                          ),
                                        ),
                                      ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedpurple = !selectedpurple;
                                    selectedblue = true;
                                    selectedblack = true;
                                    selectedbrown = true;
                                    selectedred = true;
                                    selecteddarkblue = true;
                                  });
                                  setState(() {

                                    color = "purple";


                                  });
                                  print(color);
                                },
                                child: selectedpurple
                                    ? Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffBEA9A9),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.red),
                                            //color: Colors.blueGrey,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(100))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.5),
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: const BoxDecoration(
                                                color: Color(0xffBEA9A9),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100))),
                                          ),
                                        ),
                                      ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedbrown = !selectedbrown;
                                    selectedblue = true;
                                    selectedblack = true;
                                    selectedpurple = true;
                                    selectedred = true;
                                    selecteddarkblue = true;
                                  });
                                  setState(() {

                                    color = "brown";


                                  });
                                  print(color);
                                },
                                child: selectedbrown
                                    ? Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffE2BB8D),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.red),
                                            //color: Colors.blueGrey,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(100))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.5),
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: const BoxDecoration(
                                                color: Color(0xffE2BB8D),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100))),
                                          ),
                                        ),
                                      ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selecteddarkblue = !selecteddarkblue;
                                    selectedblue = true;
                                    selectedblack = true;
                                    selectedpurple = true;
                                    selectedred = true;
                                    selectedbrown = true;
                                  });
                                  setState(() {

                                    color = "blue";


                                  });
                                  print(color);
                                },
                                child: selecteddarkblue
                                    ? Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                            color: Color(0xff151867),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.red),
                                            //color: Colors.blueGrey,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(100))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.5),
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: const BoxDecoration(
                                                color: Color(0xff151867),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100))),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        )),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Sizes",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 2.0)
                            ]),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    xs = !xs;
                                    s = true;
                                    m = true;
                                    l = true;
                                    xl = true;
                                    setState(() {

                                      size  = "xs";
                                    });


                                  });
                                  print(size);
                                },
                                child: Container(
                                  height: 40,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //     color: Colors.grey,
                                      //     blurRadius: 3.5
                                      //   )
                                      // ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: xs
                                              ? Colors.black
                                              : const Color(0xffFD8A00)),
                                      color: xs
                                          ? Colors.white
                                          : const Color(0xffFD8A00)),
                                  child: Center(
                                    child: Text(
                                      "XS",
                                      style: TextStyle(
                                          color: xs ? Colors.black : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    s = !s;
                                    xs = true;
                                    m = true;
                                    l = true;
                                    xl = true;
                                    setState(() {

                                      size  = "s";
                                    });
                                  });
                                  print(size);
                                },
                                child: Container(
                                  height: 40,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //     color: Colors.grey,
                                      //     blurRadius: 3.5
                                      //   )
                                      // ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: s
                                              ? Colors.black
                                              : const Color(0xffFD8A00)),
                                      color: s
                                          ? Colors.white
                                          : const Color(0xffFD8A00)),
                                  child: Center(
                                    child: Text(
                                      "S",
                                      style: TextStyle(
                                          color: s ? Colors.black : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    m = !m;
                                    xs = true;
                                    s = true;
                                    l = true;
                                    xl = true;
                                    setState(() {

                                      size  = "m";
                                    });
                                  });
                                  print(size);
                                },
                                child: Container(
                                  height: 40,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //     color: Colors.grey,
                                      //     blurRadius: 3.5
                                      //   )
                                      // ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: m
                                              ? Colors.black
                                              : const Color(0xffFD8A00)),
                                      color: m
                                          ? Colors.white
                                          : const Color(0xffFD8A00)),
                                  child: Center(
                                    child: Text(
                                      "M",
                                      style: TextStyle(
                                          color: m ? Colors.black : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    l = !l;
                                    m = true;
                                    xs = true;
                                    s = true;
                                    xl = true;
                                    setState(() {

                                      size  = "l";
                                    });
                                  });
                                  print(size);
                                },
                                child: Container(
                                  height: 40,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //     color: Colors.grey,
                                      //     blurRadius: 3.5
                                      //   )
                                      // ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: l
                                              ? Colors.black
                                              : const Color(0xffFD8A00)),
                                      color: l
                                          ? Colors.white
                                          : const Color(0xffFD8A00)),
                                  child: Center(
                                    child: Text(
                                      "L",
                                      style: TextStyle(
                                          color: l ? Colors.black : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    xl = !xl;
                                    m = true;
                                    xs = true;
                                    s = true;
                                    l = true;
                                    setState(() {

                                      size  = "xl";
                                    });
                                  });
                                  print(size);
                                },
                                child: Container(
                                  height: 40,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //     color: Colors.grey,
                                      //     blurRadius: 3.5
                                      //   )
                                      // ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: xl
                                              ? Colors.black
                                              : const Color(0xffFD8A00)),
                                      color: xl
                                          ? Colors.white
                                          : const Color(0xffFD8A00)),
                                  child: Center(
                                    child: Text(
                                      "XL",
                                      style: TextStyle(
                                          color: xl ? Colors.black : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 2.0)
                            ]),
                        child:  Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              const Text("Product Description:" ,style: TextStyle(color: Colors.black),),
                              const SizedBox(height: 10,),
                              // Text("Ensure the production quality is representative of your deliveries.Need help with your video? Check out our Fiverr expert audio/video talent here.",
                              // style: TextStyle(color: Colors.grey),),
                              TextFormField(
                                controller: descController,
                                maxLines: 2,
                                decoration: const InputDecoration(
                                  hintText: "Enter Description here..",
                                  border: InputBorder.none


                                ),
                              )
                            ],
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Specify Details" ,style: TextStyle(color: Colors.orange),),

                      Row(
                        children: [
                          Expanded(child: TextFormField(
                            controller: localityController,
                            decoration: const InputDecoration(hintText: "City"),
                          )),
                          const SizedBox(width: 20,),
                          Expanded(child: TextFormField(
                            controller: postalCodeController,
                            decoration: const InputDecoration(hintText: "Postal Cose"),
                          )),

                        ],
                      ),
                      TextFormField(
                        controller: conditionController,
                        decoration: const InputDecoration(
                          hintText: "Country"
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("assets/Path_34175.svg"),
                          TextButton(onPressed: (){
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('AlertDialog Title'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: const <Widget>[
                                        Text('This is a demo alert dialog.'),
                                        Text('Would you like to approve of this message?'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Approve'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }, child: const Text("Get my current location" ,style: TextStyle(color: Colors.orange),))
                        ],
                      ),


                      const SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20),child: Row(


                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 35,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50))
                              )),
                              backgroundColor: MaterialStateProperty.all(const Color(0xffFD8A00))
                          ),
                          onPressed: () async {
                            setState(() {
                            //   if (descController.text.isEmpty) {
                            //     isDescription = false;
                            //   } else {
                            //     isDescription = true;
                            //   }
                            //   if (localityController.text.isEmpty) {
                            //     isCity = false;
                            //   } else {
                            //     isCity = true;
                            //   }
                            //   if (postalCodeController.text.isEmpty) {
                            //     isPostalCode = false;
                            //   } else {
                            //     isPostalCode = true;
                            //   }
                            //   if (countryController.text.isEmpty) {
                            //     isCountry = false;
                            //   } else {
                            //     isCountry = true;
                            //   }
                            //   if (priceController.text.isNotEmpty &&
                            //       productPrice >= 10) {
                            //     isPrice = true;
                            //   } else {
                            //     isPrice = false;
                            //   }
                            //
                              showSpinner = true;
                            });
                            // showSpinner = true;
                            if ((_formKey.currentState!.validate())) {
                              imagesToBePosted.insert(0, uploadedFile);
                              for (var img in imagesToBePosted) {
                                var ref = FirebaseStorage.instance.ref().child(
                                    '${user?.email}/${path.basename(img.path)}');
                                await ref.putFile(img).whenComplete(() async {
                                  await ref.getDownloadURL().then((value) {
                                    imgRef.add(value);
                                    print(value);
                                  });
                                });
                                // print(user?.uid);
                                // print(user?.email.toString());
                                // print(ref.toString());
                                // print(ref.getDownloadURL().toString());
                                // print(imgRef);
                              }

                              userAddress =  '$_cityLocality, $_postalCode, $_country';
                              // print(userAddress);
                              firestore.collection('Posts').add({
                                'title': nameController.text,
                                'productCategory': categoryController.text,
                                'materialCondition': conditionController.text,
                                // 'brand': productBrand,
                                'images': imgRef,
                                // 'fabric': fabricController.text,
                                // 'pattern': ,
                                // 'occasion': productOccasion,

                                'size': size,
                                'color': color,
                                'description': descController.text,
                                'cost': productPrice,
                                'postedBy':  FirebaseAuth.instance.currentUser?.email,
                                'uID':  FirebaseAuth.instance.currentUser?.uid,
                                'address': userAddress,
                                'onSale': true,
                                'views': 0,
                                'time': FieldValue.serverTimestamp(),
                                "savedPosts": FieldValue.arrayUnion([0]),
                                'archive': 'no',
                              }).then((docRef) => {
                                  // Get the document ID
                                   documentId = docRef.id,
                                  print("Document ID: $documentId"),
                                firestore.collection('Posts').doc(documentId).update(
                                    {
                                      "postuid" : documentId
                                    })

                              // Use the document ID as needed
                            });

                              print(userAddress.toString());

                              setState(() {
                                // // imgRef = "" as List<String>;
                                // imgRef.clear();
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
                                      builder: (context) => const HomePage()),
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
                          }, child: const Text("Proceed"))),
                  const SizedBox(width: 20,),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 35,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(color: Colors.orange)),
                            // side: MaterialStateProperty.all(),
                              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50))
                              )),
                              backgroundColor: MaterialStateProperty.all(Colors.white)
                          ),
                          onPressed: (){
                            // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            //   return const PostProductDetails();
                            // }));
                          }, child: const Text("Save as Draft",style: TextStyle(color: Colors.orange),)))
                ],
              ),),
              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
  String? validator(String? string){
    if(string!.isEmpty){
      return "Please Enter details";
    }
    return null;
  }

}
