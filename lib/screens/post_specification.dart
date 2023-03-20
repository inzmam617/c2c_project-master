import 'package:c2c_project1/screens/post_description.dart';
import 'package:c2c_project1/screens/post_detailing.dart';
import 'package:c2c_project1/screens/post_screen.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import '../components/rounded_button.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:path/path.dart' as path;

class ProductSpecificationPage extends StatefulWidget {
  const ProductSpecificationPage({Key? key}) : super(key: key);

  @override
  State<ProductSpecificationPage> createState() =>
      _ProductSpecificationPageState();
}

class _ProductSpecificationPageState extends State<ProductSpecificationPage> {
  TextEditingController titleController = TextEditingController();
  bool isTitleValid = true;
  bool showSpinner = false;
  bool showImages = false;

  bool showImagesVis() {
    if (imagesToBePosted.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  final _formKey = GlobalKey<FormState>();

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (titleController.text.isEmpty) {
      setState(() {
        isTitleValid = false;
      });
    }
    if (isValid! && titleController.text.isNotEmpty) {
      setState(() {
        isTitleValid = true;
      });
      _formKey.currentState?.save();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProductDescriptionPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Add Product Details'),
            TextButton(
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                imagesToBePosted.insert(0, uploadedFile);
                for (var img in imagesToBePosted) {
                  var ref = FirebaseStorage.instance
                      .ref()
                      .child('${user?.email}/${path.basename(img.path)}');
                  await ref.putFile(img).whenComplete(() async {
                    await ref.getDownloadURL().then((value) {
                      imgRef.add(value);
                    });
                  });
                }

                FirebaseFirestore.instance
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
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Saved as Draft!'),
                  ));
                });
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(children: [
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Selected Pictures: ',
                  style: kSendButtonTextStyle,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: 200.0,
                height: 200.0,
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(uploadedFile), fit: BoxFit.cover),
                ),
              ),
              Visibility(
                visible: showImagesVis(),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 100.0,
                        height: 90.0,
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imagesToBePosted.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(imagesToBePosted[index]),
                                      fit: BoxFit.cover),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Specify Details: ',
                  style: kSendButtonTextStyle,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: titleController,
                maxLength: 50,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                enableSuggestions: true,
                textCapitalization: TextCapitalization.words,
                decoration: kPostTextFieldDecoration.copyWith(
                  labelText: 'Title',
                  hintText: 'Give title to the product',
                  counterText: '',
                  errorText: isTitleValid ? null : 'Field Cannot Be Left Empty',
                ),
                onChanged: (value) {
                  productTitle = value;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              DropdownButtonFormField(
                focusColor: Colors.blue,
                icon: const Icon(Icons.arrow_drop_down),
                decoration: kPostTextFieldDecoration.copyWith(
                  labelText: 'Product Category',
                  hintText: 'Select Category',
                ),
                items: categoryItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  productCategory = value as String;
                },
                validator: (value) =>
                    value == null ? 'Field Cannot Be Left Empty' : null,
              ),
              const SizedBox(
                height: 10.0,
              ),
              DropdownButtonFormField(
                focusColor: Colors.blue,
                icon: const Icon(Icons.arrow_drop_down),
                decoration: kPostTextFieldDecoration.copyWith(
                  labelText: 'Material Condition',
                  hintText: 'Select Condition',
                ),
                items: materialItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  materialCondition = value as String;
                },
                validator: (value) =>
                    value == null ? 'Field Cannot Be Left Empty' : null,
              ),
              const SizedBox(
                height: 10.0,
              ),
              DropdownButtonFormField(
                focusColor: Colors.blue,
                icon: const Icon(Icons.arrow_drop_down),
                decoration: kPostTextFieldDecoration.copyWith(
                  labelText: 'Color',
                  hintText: 'Select Color',
                ),
                items: colorItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  productColor = value as String;
                },
                validator: (value) =>
                    value == null ? 'Field Cannot Be Left Empty' : null,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: kPostTextFieldDecoration.copyWith(
                  labelText: 'Sub Color (Optional)',
                  hintText: 'You can add a more specific color.',
                ),
                onChanged: (value) {
                  productSubColor = value;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              DropdownButtonFormField(
                focusColor: Colors.blue,
                icon: const Icon(Icons.arrow_drop_down),
                decoration: kPostTextFieldDecoration.copyWith(
                  labelText: 'Occasion',
                  hintText: 'Select Occasion',
                ),
                items: occasionItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  productOccasion = value as String;
                },
                validator: (value) =>
                    value == null ? 'Field Cannot Be Left Empty' : null,
              ),
              const SizedBox(
                height: 10.0,
              ),
              DropdownButtonFormField(
                focusColor: Colors.blue,
                icon: const Icon(Icons.arrow_drop_down),
                decoration: kPostTextFieldDecoration.copyWith(
                  labelText: 'Size',
                  hintText: 'Select Size',
                ),
                items: sizeItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  productSize = value as String;
                },
                validator: (value) =>
                    value == null ? 'Field Cannot Be Left Empty' : null,
              ),
              const SizedBox(
                height: 10.0,
              ),
              DropdownButtonFormField(
                focusColor: Colors.blue,
                icon: const Icon(Icons.arrow_drop_down),
                decoration: kPostTextFieldDecoration.copyWith(
                  labelText: 'Fabric',
                  hintText: 'Select Fabric',
                ),
                items: fabricItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  productFabric = value as String;
                },
                validator: (value) =>
                    value == null ? 'Field Cannot Be Left Empty' : null,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Add More Details (Optional): ',
                  style: kSendButtonTextStyle,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: kPostTextFieldDecoration.copyWith(
                  labelText: 'Brand',
                  hintText: 'Select Brand',
                ),
                onChanged: (value) {
                  productBrand = value;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: kPostTextFieldDecoration.copyWith(
                  labelText: 'Pattern',
                  hintText: 'Select Pattern',
                ),
                onChanged: (value) {
                  productPattern = value;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              RoundedButton(
                title: 'Next',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  _submit();
                },
                textColor: Colors.white,
                fontSize: kFontSize,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
