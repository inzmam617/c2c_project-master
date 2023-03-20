import 'package:c2c_project1/components/onSaleLayout.dart';
import 'package:c2c_project1/screens/edit_product_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/rounded_button.dart';
import '../constants.dart';

class EditProductDetails extends StatefulWidget {
  const EditProductDetails({Key? key}) : super(key: key);

  @override
  State<EditProductDetails> createState() => _EditProductDetailsState();
}

class _EditProductDetailsState extends State<EditProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Edit Product Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: GridView.builder(
                        itemCount: editImages.length,
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(editImages[index]),
                                  fit: BoxFit.cover),
                            ),
                          );
                        }),
                  ),
                ),
              ],
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
              maxLength: 50,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.words,
              decoration: kPostTextFieldDecoration.copyWith(
                labelText: 'Title',
                hintText: 'Give title to the product',
                counterText: '',
              ),
              onChanged: (value) {
                editTitle = value;
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
                editCategory = value as String;
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
                editCondition = value as String;
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
                editColor = value as String;
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
                //editSubColor = value;
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
                editOccasion = value as String;
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
                editSize = value as String;
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
                editFabric = value as String;
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
                editBrand = value;
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
                editPattern = value;
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            RoundedButton(
              title: 'Next',
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProductDescription(
                            editDescription: editDescription,
                            editPrice: editPrice,
                            editAddress: editAddress,
                          )),
                );
              },
              textColor: Colors.white,
              fontSize: kFontSize,
            ),
          ]),
        ),
      ),
    );
  }
}
