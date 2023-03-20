import 'dart:io';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:c2c_project1/components/rounded_button.dart';
import 'package:c2c_project1/screens/storageManager.dart';
import 'package:c2c_project1/screens/post_detailing.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import '../constants.dart';

late String uploadedDraftImage;
late File uploadedFile;
String description = '';
int productPrice = 0;
late String postUser;
String userAddress = '';
List<String> imgRef = [];
String productTitle = '';
String productCategory = '';
String materialCondition = '';
String productBrand = '';
String productFabric = '';
String productPattern = '';
String productColor = '';
String productSubColor = '';
String productOccasion = '';
String productSize = '';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: UploadingPage(),
    );
  }
}

class UploadingPage extends StatefulWidget {
  const UploadingPage({Key? key}) : super(key: key);

  @override
  State<UploadingPage> createState() => _UploadingPageState();
}

class _UploadingPageState extends State<UploadingPage> {
  final Storage storage = Storage();
  bool showSpinner = false;

  XFile? uploadImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_a_photo,
                  size: 50.0,
                  color: Colors.grey,
                ),
                RoundedButton(
                  title: "Choose Photo",
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });

                    final uploadImage = await ImagePicker().pickImage(
                        source: ImageSource.gallery, imageQuality: 25);

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
                      final fileName = Path.basename(uploadImage.path);
                      uploadedDraftImage = fileName.toString();

                      uploadedFile = File(path);
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductDetailPage()),
                      );
                    }
                  },
                  fontSize: kFontSize,
                ),
                const Icon(
                  Icons.camera_alt_outlined,
                  size: 50.0,
                  color: Colors.grey,
                ),
                RoundedButton(
                  title: "Take Photo",
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });

                    uploadImage = await ImagePicker().pickImage(
                        source: ImageSource.camera, imageQuality: 50);

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
                      final path = uploadImage?.path;
                      final fileName = Path.basename(path!);
                      uploadedDraftImage = fileName.toString();

                      uploadedFile = File(path);
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductDetailPage()),
                      );
                    }
                  },
                  fontSize: kFontSize,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
