import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password.',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kPostTextFieldDecoration = InputDecoration(
  labelText: 'Sample Text',
  hintMaxLines: 10,
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  hintText: 'Sample Text Hint',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
);

InputDecoration kSearchBarDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
    borderSide: const BorderSide(width: 0.9, color: Colors.white),
  ),
);

const categoryItems = [
  'Suit',
  'Lehenga',
  'Lashkara',
  'Patiala',
  'Plaazo',
  'Saree',
];

const materialItems = [
  'Poor',
  'Good',
  'Excellent',
  'Brand New',
];

const colorItems = [
  'Off-White',
  'White',
  'Golden',
  'Green',
  'Red',
  'Violet',
  'Yellow',
  'Blue',
  'Orange',
  'Black',
  'Indigo',
  'Brown',
];

const fabricItems = [
  'Cotton',
  'Silk',
  'Georgette',
  'Velvet',
  'Felt',
  'Rayon',
];

const kFontSize = 15.0;

const occasionItems = ['Wedding', 'Anniversary', 'Birthday', 'Festival'];

const sizeItems = ['XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL'];
