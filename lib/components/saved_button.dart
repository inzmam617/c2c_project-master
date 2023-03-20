import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class SaveButton extends StatefulWidget {
  const SaveButton(
      {Key? key,
      required this.ifSaved,
      required this.uID,
      required this.iconSize})
      : super(key: key);

  final bool ifSaved;
  final String uID;
  final double iconSize;

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    getStream(){
      return FirebaseFirestore.instance.collection("UserProfile").doc(FirebaseAuth.instance.currentUser?.uid).snapshots();
    }
    bool saved = widget.ifSaved;

    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return StreamBuilder <DocumentSnapshot<Map<String, dynamic>>>(
          stream: getStream(),
          builder: (context, snapshot) {
            return IconButton(
                onPressed: () async {
                  setState(() {
                    saved
                        ? {
                            saved = false,
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Item removed from wishlist 💔'))),
                          }
                        : {
                            saved = true,
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Item added to wishlist ❤'))),
                          };
                  });

                  saved ? await _firestore
                          .collection("userProfile")
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .update({
                          "savedPosts": FieldValue.arrayUnion([widget.uID]),
                        })
                      : await _firestore
                          .collection("userProfile")
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .update({
                          "savedPosts": FieldValue.arrayRemove([widget.uID])
                        });
                },
                selectedIcon: const Icon(
                  Icons.favorite_outlined,
                  color: Colors.redAccent,
                ),
                icon: saved
                    ? Center(
                      child: SvgPicture
                          .asset('assets/Heart.svg'))
                    : Center(
                      child: SvgPicture
                            .asset('assets/EHeart.svg'))
            );
          }
        );
      },
    );
  }
}
