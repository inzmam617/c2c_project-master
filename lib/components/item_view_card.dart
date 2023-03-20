import 'package:c2c_project1/components/saved_button.dart';
import 'package:c2c_project1/screens/product_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

late String productDisplayImage;
late List<String> productImages;
late String productDisplayCost;
late String productDisplayTitle;
late String productDisplayCategory;
late String productDisplayBrand;
late String productDisplayCondition;
late String productDisplayColor;
late String productDisplayFabric;
late String productDisplayPattern;
late String productDisplayDescription;
late String productOwner;
late String productUserID;
late String productUserAddress;
late bool productOnSale;
late String productID;
late bool savedPost;
late Timestamp postDate;

class ItemCardView extends StatefulWidget {
  const ItemCardView({
    Key? key,
    required this.title,
    required this.cost,
    required this.imageUrl,
    required this.category,
    required this.brand,
    required this.color,
    required this.fabric,
    required this.pattern,
    required this.description,
    required this.owner,
    required this.condition,
    required this.uID,
    required this.address,
    required this.images,
    required this.onSale,
    required this.docID,
    required this.savedPost,
    required this.postedOn,
  }) : super(key: key);

  final String title;
  final String cost;
  final String imageUrl;
  final String category;
  final String brand;
  final String color;
  final String fabric;
  final String pattern;
  final String description;
  final String owner;
  final String condition;
  final String uID;
  final String address;
  final List<String> images;
  final bool onSale;
  final String docID;
  final bool savedPost;
  final Timestamp postedOn;

  @override
  State<ItemCardView> createState() => _ItemCardViewState();
}

class _ItemCardViewState extends State<ItemCardView> {
  @override
  void initState() {
    widget.savedPost;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool saved = widget.savedPost;
    setState(() {
      saved;
    });

    return TextButton(
      onPressed: () {
        productDisplayImage = widget.imageUrl;
        productDisplayCost = widget.cost;
        productDisplayTitle = widget.title;
        productDisplayDescription = widget.description;
        productDisplayPattern = widget.pattern;
        productDisplayFabric = widget.fabric;
        productDisplayColor = widget.color;
        productDisplayCondition = widget.condition;
        productDisplayBrand = widget.brand;
        productDisplayCategory = widget.category;
        productOwner = widget.owner;
        productUserID = widget.uID;
        productUserAddress = widget.address;
        productImages = widget.images;
        productOnSale = widget.onSale;
        productID = widget.docID;
        savedPost = widget.savedPost;
        postDate = widget.postedOn;

        _firestore
            .collection('Posts')
            .doc(widget.docID)
            .update({'views': FieldValue.increment(1)});

        Navigator.of(context, rootNavigator: true).push(// ensures fullscreen
            CupertinoPageRoute(builder: (BuildContext context) {
          return const ProductDisplay();
        }));
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey.shade200,
      ),
      child: Column(
        children: <Widget>[
          widget.onSale
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.imageUrl,
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     fit: BoxFit.cover,
                  //     image: NetworkImage(
                  //       widget.imageUrl,
                  //     ),
                  //   ),
                  // ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.39,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SaveButton(
                          ifSaved: saved,
                          uID: widget.docID,
                          iconSize: 25.0,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      opacity: 50.0,
                      image: NetworkImage(
                        widget.imageUrl,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SaveButton(
                        ifSaved: saved,
                        uID: widget.docID,
                        iconSize: 25.0,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      RotationTransition(
                        turns: const AlwaysStoppedAnimation(-45 / 360),
                        child: Center(
                          child: Text(
                            'Sold',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.08),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
