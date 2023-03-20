import 'package:c2c_project1/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../components/onSaleLayout.dart';

class DraftProduct extends StatefulWidget {
  const DraftProduct({Key? key}) : super(key: key);

  @override
  State<DraftProduct> createState() => _DraftProductState();
}

class _DraftProductState extends State<DraftProduct> {
  final SliverSimpleGridDelegate gridDelegate =
      const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);

  @override
  Widget build(BuildContext context) {
    return ProductLayout(
      querySnapshot: FirebaseFirestore.instance
          .collection('Drafts')
          .doc(user?.uid)
          .collection('Products')
          .snapshots(),
      snackBarText: 'Draft Deleted 🗑️',
      buttonText: '',
      archive: '',
      markAsSoldVisibility: false,
      archiveButtonVisibility: false,
      deleteButtonVisibility: true,
    );
  }
}
