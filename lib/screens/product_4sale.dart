import 'package:c2c_project1/components/onSaleLayout.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ForSaleProduct extends StatefulWidget {
  const ForSaleProduct({Key? key}) : super(key: key);

  @override
  State<ForSaleProduct> createState() => _ForSaleProductState();
}

class _ForSaleProductState extends State<ForSaleProduct> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return ProductLayout(
      querySnapshot: firestore
          .collection('Posts')
          .where('uID', isEqualTo: user?.uid)
          .where('archive', isEqualTo: 'no')
          .snapshots(),
      snackBarText: 'Item has been added to archive!',
      buttonText: 'Archive Item',
      archive: 'yes',
      markAsSoldVisibility: true,
      archiveButtonVisibility: true,
      deleteButtonVisibility: false,
    );
  }
}
