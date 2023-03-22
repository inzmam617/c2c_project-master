
import 'dart:io';

import 'package:c2c_project1/screens/storageManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart' as Path;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  String firstName = "";
  String lastName = "";
  String Email = "";
  String Address = "";
  int Phone = 0;
  File? uploadImage;
  final _firestore = FirebaseFirestore.instance;
  final Storage storage = Storage();
  String editProfile = "";
  String editUsername = '';
//   _getFromCamera() async {
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.camera,
//       maxWidth: 1800,
//       maxHeight: 1800,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         imageFile = File(pickedFile.path);
//       });
//     }
//   }
// }

  // getProfilePicture() {
  //   FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
  //       future: _firestore.collection("userProfile").doc(user?.uid).get(),
  //       builder: (context, dataShot) {
  //         if (dataShot.hasData) {
  //           var userName = dataShot.data?.get("username");
  //           var profilePicture = dataShot.data?.get("profilePicture");
  //           var about = dataShot.data?.get("aboutSection");
  //
  //           setState(() {
  //             editUsername = userName;
  //             editProfile = profilePicture;
  //             editAbout = about;
  //             // print(editAbout);
  //           });
  //         }
  //
  //         return Container();
  //       });
  //
  //   if (editProfile != '') {
  //     return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: TextButton(
  //         onPressed: () {},
  //         child: ProfilePicture(
  //           name: editUsername,
  //           radius: 100.0,
  //           fontsize: 21,
  //           img: editProfile,
  //         ),
  //       ),
  //     );
  //   } else {
  //     return Padding(
  //       padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
  //       child: TextButton(
  //         onPressed: () {},
  //         child: ProfilePicture(
  //           name: editUsername,
  //           radius: 100.0,
  //           fontsize: 21,
  //         ),
  //       ),
  //     );
  //   }
  // }
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  // final _formKey? form = _formKey.currentState;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool showSpinner = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontSize: 18, color: Color(0xff020203)),
        ),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(
                  height: 100,
                  width: 100,
                  decoration:  BoxDecoration(


                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:  AssetImage("assets/blank-profile-picture-973460_1280.webp")),
                         // image:    Image.file(uploadImage!),),
                        // AssetImage("assets/istockphoto-1189191538-170667a.jpg" ,)

                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.5
                      )
                    ]
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3.5
                          )
                        ],
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(100)),

                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            pickImage();
                            //  PickedFile pickedfile = (await ImagePicker()
                            //     .pickImage(source: ImageSource.gallery)) as PickedFile;
                            //
                            // if (uploadImage == null) {
                            //   setState(() {
                            //     showSpinner = false;
                            //   });
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text('No File Selected!'),
                            //     ),
                            //   );
                            // } else {
                            //   final path = uploadImage?.path;
                            //   final fileName = '${FirebaseAuth.instance.currentUser?.email}-${Path.basename(uploadImage!.path)}';
                            //
                            //   print(uploadImage?.path);
                            //
                            //   storage.uploadFile(path.toString(), fileName.toString()).then((value) async {
                            //
                            //     editProfile = await storage.downloadUrl(fileName);
                            //
                            //
                            //     setState(
                            //           () {
                            //         // getProfilePicture();
                            //         showSpinner = false;
                            //       },
                            //      );
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //        SnackBar(
                            //         content: Text('Profile Updated!'+ editProfile),
                            //       ),
                            //     );
                            //   });
                            // }
                          },
                          icon: const Icon(Icons.camera_alt , color: Colors.white , size: 16,),
                        ),
                      ),
                    ),
                  )
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: TextFormField(
                    validator: Name,
                    onChanged :(value) {
                      setState(() {
                        firstName = value;
                      });
                  },
                    cursorColor: Colors.black,
                    cursorWidth: 0.5,
                    style: const TextStyle(color: Color(0xffC0BDBD), fontSize: 12),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 18),
                        prefixIcon: SvgPicture.asset(
                          "assets/Iconly-Bulk-Profile.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        hintText: "First Name",
                        hintStyle:
                            const TextStyle(color: Color(0xffC0BDBD), fontSize: 12),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: TextFormField(
                    validator: Name,
                    onChanged :(value) {
                      setState(() {
                        lastName = value;
                      });
                    },
                    cursorColor: Colors.black,
                    cursorWidth: 0.5,
                    style: const TextStyle(color: Color(0xffC0BDBD), fontSize: 12),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 18),
                        prefixIcon: SvgPicture.asset(
                          "assets/Iconly-Bulk-Profile.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        hintText: "Last Name",
                        hintStyle:
                            const TextStyle(color: Color(0xffC0BDBD), fontSize: 12),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                ),

                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: TextFormField(
                    validator: address,
                    onChanged :(value) {
                      setState(() {
                        Address = value;
                      });
                    },
                    cursorColor: Colors.black,
                    cursorWidth: 0.5,
                    style: const TextStyle(color: Color(0xffC0BDBD), fontSize: 12),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 18),
                        prefixIcon: SvgPicture.asset(
                          "assets/Location.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        hintText: "Address",
                        hintStyle:
                            const TextStyle(color: Color(0xffC0BDBD), fontSize: 12),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: TextFormField(

                    validator: validateMobile,
                    keyboardType: TextInputType.phone,
                    onChanged :(value) {
                      setState(() {
                        Phone = int.parse(value);
                      });
                    },
                    cursorColor: Colors.black,
                    cursorWidth: 0.5,
                    style: const TextStyle(color: Color(0xffC0BDBD), fontSize: 12),
                    decoration: InputDecoration(

                        contentPadding: const EdgeInsets.only(top: 18),
                        prefixIcon: SvgPicture.asset(
                          "assets/Call.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        hintText: "Phone Number",
                        hintStyle:
                            const TextStyle(color: Color(0xffC0BDBD), fontSize: 12),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: 195,
                  height: 35,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _firestore.collection('userProfile').doc(FirebaseAuth.instance.currentUser?.uid).update({
                            'username': firstName,
                            "lastname" : lastName,
                            'profilePicture': editProfile,
                            // "email" : Email,
                            "Phone" : Phone

                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Changes Saved!')));
                        } else {
                          print('Form is invalid');
                        }
                        // _firestore.collection('userProfile').doc(FirebaseAuth.instance.currentUser?.uid).update({
                        //   'username': firstName,
                        //   "lastname" : lastName,
                        //   'profilePicture': editProfile,
                        //   // "email" : Email,
                        //   "Phone" : Phone
                        //
                        // });
                        // Navigator.pop(context);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text('Changes Saved!')));

                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFD8A00),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(32)))),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Poppins",
                            color: Colors.white),
                      )),
                ),
                // image != null ? Image.file(image!): Text("No image selected")
              ],
            ),
          ),
        ),
      ),
    );
  }
  // String? validateEmail(String? value) {
  //   String pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regex = RegExp(pattern);
  //   if(value!.isEmpty){
  //     return 'Email cannot be empty';
  //   }
  //   if (!regex.hasMatch(value))
  //     return 'Enter Valid Email';
  //   else
  //     return null;
  // }
  String? validateMobile(String? value) {
    // Indian Mobile number are of 10 digit only
    if(value!.isEmpty){
      return "Phone cannot be empty";
    }
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }
  String? Name(String? value) {
    // Indian Mobile number are of 10 digit only
    if(value!.isEmpty){
      return "Please enter your name.";
    }
    // if (value.length != 10)
    //   return 'Mobile Number must be of 10 digit';
    else {
      return null;
    }
  }
  String? address(String? value) {
    // Indian Mobile number are of 10 digit only
    if(value!.isEmpty){
      return "Please enter your Address.";
    }
    // if (value.length != 10)
    //   return 'Mobile Number must be of 10 digit';
    else {
      return null;
    }
  }
}
