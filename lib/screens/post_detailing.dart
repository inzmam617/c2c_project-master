import 'package:c2c_project1/screens/post_screen.dart';
import 'package:c2c_project1/screens/post_specification.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:io';
import '../components/rounded_button.dart';
import '../constants.dart';

List<File> imagesToBePosted = [];

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool showSpinner = false;
  bool uploading = false;
  final List<File> _image = [];
  int counter = 0;

  displayImage() {
    if (_image.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: 100.0,
          height: 100.0,
          child: Center(child: Text('You can add up to 7 more images!')),
        ),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: SizedBox(
              width: 100.0,
              height: 150.0,
              child: GridView.builder(
                  itemCount: _image.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(_image[index]), fit: BoxFit.cover),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _image.removeAt(index);
                              counter -= 1;
                            });
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      );
    }
  }

  chooseImage() async {
    final uploadImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

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
      File file = File(path);

      setState(() {
        _image.add(file);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Add Product Images'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                const Text(
                  'Product Picture:',
                  style: kSendButtonTextStyle,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(uploadedFile)),
                          ),
                          width: 150.0,
                          height: 150.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.cancel,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (counter != 7 && _image.length != 7) {
                            chooseImage();
                            counter += 1;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('You cannot post more images!'),
                              ),
                            );
                          }
                        },
                        child: const Icon(
                          Icons.add_photo_alternate,
                          size: 70.0,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                displayImage(),
                RoundedButton(
                  title: 'Proceed',
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    imagesToBePosted = _image;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ProductSpecificationPage()),
                    );
                  },
                  textColor: Colors.white,
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
