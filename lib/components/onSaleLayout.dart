import 'package:c2c_project1/screens/edit_product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../screens/profile.dart';

String search = '';
late List<dynamic> editImages;
late String editCategory;
late String editTitle;
late String editColor;
late String editCondition;
late String editFabric;
late String editBrand;
late String editPattern;
late String editDescription;
late int editPrice;
late String editAddress;
late String editDraftID;
late String editSize;
late String editOccasion;

class ProductLayout extends StatefulWidget {
  const ProductLayout({
    Key? key,
    required this.querySnapshot,
    required this.snackBarText,
    required this.buttonText,
    required this.archive,
    required this.markAsSoldVisibility,
    required this.archiveButtonVisibility,
    required this.deleteButtonVisibility,
  }) : super(key: key);

  final Stream<QuerySnapshot<Object?>>? querySnapshot;
  final String archive;
  final String snackBarText;
  final String buttonText;
  final bool deleteButtonVisibility;
  final bool archiveButtonVisibility;
  final bool markAsSoldVisibility;

  @override
  State<ProductLayout> createState() => _ProductLayoutState();
}

class _ProductLayoutState extends State<ProductLayout> {
  final _firestore = FirebaseFirestore.instance;
  String markSold = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.querySnapshot,
      builder: (context, snapshot) {
        try {
          final drafts = snapshot.data?.docs;
          List<TextButton> draftItems = [];

          for (var draft in drafts!) {
            var draftTitle = draft['title'];
            var draftImages = draft['images'];
            var draftViews = draft['views'];
            var draftOnSale = draft['onSale'];
            var draftCategory = draft['productCategory'];
            var draftColor = draft['color'];
            var draftCondition = draft['materialCondition'];
            var draftFabric = draft['fabric'];
            var draftBrand = draft['brand'];
            var draftPattern = draft['pattern'];
            var draftAddress = draft['address'];
            var draftCost = draft['cost'];
            var draftDescription = draft['description'];
            //var draftSize = draft['size'];
            //var draftOccasion = draft['occasion'];
            // var draftSubColor = draft['subColor'];
            var draftID = draft.id;

            if (draftOnSale) {
              markSold = 'Mark as Sold';
            } else {
              markSold = 'Put on Sale';
            }

            draftItems.add(
              TextButton(
                onPressed: () {
                  editImages = draftImages;
                  editCategory = draftCategory;
                  editTitle = draftTitle;
                  editAddress = draftAddress;
                  editBrand = draftBrand;
                  editColor = draftColor;
                  editCondition = draftCondition;
                  editDescription = draftDescription;
                  editFabric = draftFabric;
                  editPattern = draftPattern;
                  editPrice = draftCost;
                  editDraftID = draftID;
                  //editSize = draftSize;
                  //editOccasion = draftOccasion;
                  // editSubColor = draftSubColor;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProductDetails()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 70.0,
                        child: draftOnSale
                            ? Image.network(
                                draftImages[0],
                                fit: BoxFit.contain,
                              )
                            : Container(
                                height: 70.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    opacity: 50.0,
                                    image: NetworkImage(
                                      draftImages[0],
                                    ),
                                  ),
                                ),
                                child: const RotationTransition(
                                  turns: AlwaysStoppedAnimation(-45 / 360),
                                  child: Center(
                                    child: Text(
                                      'Sold',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                (draftTitle == '') ? 'No Title' : draftTitle,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                    color: Colors.black),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.0)),
                              Text(
                                (draftViews != 0)
                                    ? '$draftViews views'
                                    : 'No views',
                                style: const TextStyle(
                                    fontSize: 11.0, color: Colors.black54),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0)),
                              Row(
                                children: [
                                  Visibility(
                                    visible: widget.deleteButtonVisibility,
                                    child: TextButton(
                                      onPressed: () async {
                                        await _firestore
                                            .collection('Drafts')
                                            .doc(user?.uid)
                                            .collection('Products')
                                            .doc(draft.id)
                                            .delete()
                                            .then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(widget.snackBarText),
                                          ));
                                        });
                                      },
                                      child: const Text('Delete from drafts'),
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.archiveButtonVisibility,
                                    child: TextButton(
                                      onPressed: () async {
                                        await _firestore
                                            .collection('Posts')
                                            .doc(draft.id)
                                            .update({
                                          'archive': widget.archive
                                        }).then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(widget.snackBarText),
                                          ));
                                        });
                                      },
                                      child: Text(widget.buttonText),
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.markAsSoldVisibility,
                                    child: TextButton(
                                      onPressed: () {
                                        draftOnSale
                                            ? {
                                                // showDialog(
                                                //   context: context,
                                                //   builder: (ctx) => AlertDialog(
                                                //     title: const Text(
                                                //         "To Whom Did You Sell It?\nCan you rate them?"),
                                                //     content: StatefulBuilder(
                                                //       builder: (BuildContext
                                                //               context,
                                                //           void Function(
                                                //                   void
                                                //                       Function())
                                                //               setState) {
                                                //         return SizedBox(
                                                //           width: MediaQuery.of(
                                                //                       context)
                                                //                   .size
                                                //                   .width *
                                                //               0.7,
                                                //           height: MediaQuery.of(
                                                //                       context)
                                                //                   .size
                                                //                   .height *
                                                //               0.5,
                                                //           child: Column(
                                                //             crossAxisAlignment:
                                                //                 CrossAxisAlignment
                                                //                     .start,
                                                //             children: [
                                                //               TextFormField(
                                                //                 decoration: kTextFieldDecoration.copyWith(
                                                //                     labelText:
                                                //                         'Search User',
                                                //                     hintText:
                                                //                         'Type any username'),
                                                //                 onChanged:
                                                //                     (value) {
                                                //                   setState(() {
                                                //                     search =
                                                //                         value;
                                                //                   });
                                                //                 },
                                                //               ),
                                                //               const SizedBox(
                                                //                 height: 10.0,
                                                //               ),
                                                //               Expanded(
                                                //                 child:
                                                //                     SearchUsers(
                                                //                   search:
                                                //                       search,
                                                //                 ),
                                                //               ),
                                                //             ],
                                                //           ),
                                                //         );
                                                //       },
                                                //     ),
                                                //     actions: <Widget>[
                                                //       TextButton(
                                                //         onPressed: () {
                                                //           setState(() {
                                                //             search = '';
                                                //           });
                                                //           Navigator.of(ctx)
                                                //               .pop();
                                                //         },
                                                //         child: const Text(
                                                //             "Not Now"),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                _firestore
                                                    .collection('Posts')
                                                    .doc(draft.id)
                                                    .update({
                                                  'onSale': false
                                                }).then((value) {
                                                  setState(() {
                                                    markSold = 'Put On Sale';
                                                  });
                                                })
                                              } // implement set state
                                            : _firestore
                                                .collection('Posts')
                                                .doc(draft.id)
                                                .update({'onSale': true}).then(
                                                    (value) {
                                                setState(() {
                                                  markSold = 'Mark as Sold';
                                                });
                                              });
                                      },
                                      child: Text(markSold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16.0,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            );
          }
          return MasonryGridView.count(
            shrinkWrap: true,
            crossAxisCount: 1,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            itemCount: draftItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: draftItems[index],
              );
            },
          );
        } catch (e) {
          print(e); //fix this exception at the later stage!!!
        }

        return Container();
      },
    );
  }
}
