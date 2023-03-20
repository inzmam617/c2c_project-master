import 'package:c2c_project1/components/onSaleLayout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:flutter/material.dart';

class ArchivedProducts extends StatefulWidget {
  const ArchivedProducts({Key? key}) : super(key: key);

  @override
  State<ArchivedProducts> createState() => _ArchivedProductsState();
}

class _ArchivedProductsState extends State<ArchivedProducts> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return ProductLayout(
      querySnapshot: firestore
          .collection('Posts')
          .where('uID', isEqualTo: user?.uid)
          .where('archive', isEqualTo: 'yes')
          .snapshots(),
      snackBarText: 'Item has been removed from archive',
      buttonText: 'Remove from Archive',
      archive: 'no',
      markAsSoldVisibility: false,
      archiveButtonVisibility: true,
      deleteButtonVisibility: false,
    );
  }
}
