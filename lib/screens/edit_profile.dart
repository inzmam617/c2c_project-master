import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as Path;
import 'package:c2c_project1/screens/profile.dart';
import '../components/rounded_button.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'storageManager.dart';

final _firestore = FirebaseFirestore.instance;

String editUsername = '';
late String editProfile;
String editAbout = '';
late String name;
late String hintAbout;
bool enableEditUsername = false;
bool enableEditAbout = false;

class EditSProfile extends StatefulWidget {
  const EditSProfile({Key? key}) : super(key: key);

  @override
  State<EditSProfile> createState() => _EditSProfileState();
}

class _EditSProfileState extends State<EditSProfile> {
  bool showSpinner = false;

  getProfilePicture() {
    FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _firestore.collection("userProfile").doc(user?.uid).get(),
        builder: (context, dataShot) {
          if (dataShot.hasData) {
            var userName = dataShot.data?.get("username");
            var profilePicture = dataShot.data?.get("profilePicture");
            var about = dataShot.data?.get("aboutSection");

            setState(() {
              editUsername = userName;
              editProfile = profilePicture;
              editAbout = about;
              // print(editAbout);
            });
          }

          return Container();
        });

    if (editProfile != '') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: () {},
          child: ProfilePicture(
            name: editUsername,
            radius: 100.0,
            fontsize: 21,
            img: editProfile,
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: TextButton(
          onPressed: () {},
          child: ProfilePicture(
            name: editUsername,
            radius: 100.0,
            fontsize: 21,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: ListView(children: [
          Center(
              child: Column(
            children: [
              getProfilePicture(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        final uploadImage = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (uploadImage == null) {
                          setState(() {
                            showSpinner = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No File Selected!'),
                            ),
                          );
                        } else {
                          final path = uploadImage.path;
                          final fileName =
                              '${user?.email}-${Path.basename(uploadImage.path)}';

                          storage
                              .uploadFile(path.toString(), fileName.toString())
                              .then((value) async {
                            editProfile = await storage.downloadUrl(fileName);
                            setState(
                              () {
                                getProfilePicture();
                                showSpinner = false;
                              },
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Profile Updated!'),
                              ),
                            );
                          });
                        }
                      },
                      child: const Icon(Icons.edit)),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          editProfile = '';
                        });
                      },
                      child: const Icon(Icons.delete)),
                ],
              ),
            ],
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username: ',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          enabled: enableEditUsername,
                          hintText: editUsername,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            editUsername = value;
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        enableEditUsername = true;
                      });
                    },
                    child: const Icon(Icons.edit)),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Center(
            child: RoundedButton(
              title: 'Save',
              color: Colors.lightBlueAccent,
              onPressed: () {
                setState(() {
                  enableEditAbout = false;
                  enableEditUsername = false;
                });
                _firestore.collection('userProfile').doc(user?.uid).update({
                  'username': editUsername,
                  'profilePicture': editProfile,
                  'aboutSection': editAbout,
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Changes Saved!')));
              },
              textColor: Colors.white,
              fontSize: kFontSize,
            ),
          ),
        ]),
      ),
    );
  }
}
