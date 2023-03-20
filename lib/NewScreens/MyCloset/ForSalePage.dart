import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../AllPosts/ProductDetails/ProductDetails.dart';

class ForSale extends StatefulWidget {
  const ForSale({Key? key}) : super(key: key);

  @override
  State<ForSale> createState() => _ForSaleState();
}

class _ForSaleState extends State<ForSale> {
  getStream(){
    return FirebaseFirestore.instance.collection("Posts")
        .where('uID', isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots();
  }
  List dresstwo = [
    "one.jpg",
    "two.jpg",
    "three.jpg",
    "four.jpg",
    "five.jpg",
    "six.jpg",
    "seven.jpg",
    "eight.jpg",
    "dressSeven.png",
    "dressEight.png",
    "dressNine.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
            stream: getStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  // height: MediaQuery.of(context).size.height / 2 ,
                  child: GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio:
                          ((MediaQuery.of(context)
                              .size
                              .width /
                              3) /
                              310),
                          crossAxisCount: 3),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext ctx, index) {
                        List<dynamic> savedPosts = snapshot
                            .data?.docs[index]["savedPosts"];
                        // print(snapshot
                        //     .data?.docs[index]["savedPosts"]);

                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder:
                                              (BuildContext
                                          context) {
                                            return ProductDetails(
                                              details: snapshot
                                                  .data?.docs[index],
                                            );
                                          }));
                                },
                                child: Container(
                                  width:
                                  MediaQuery.of(context)
                                      .size
                                      .width /
                                      3,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              (snapshot.data?.docs[
                                              index]
                                              [
                                              "images"]
                                              [0]) ??
                                                  ""),
                                          fit: BoxFit.cover),
                                      borderRadius:
                                      BorderRadius
                                          .circular(1.5)),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .end,
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: const [
                                      // Transform.translate(
                                      //   offset: const Offset(
                                      //       -10, 10),
                                      //   child:        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                      //     stream: FirebaseFirestore.instance
                                      //         .collection('userProfile')
                                      //         .doc(FirebaseAuth.instance.currentUser?.uid)
                                      //         .snapshots(),
                                      //     builder: (context, datashot) {
                                      //       if (datashot.hasData) {
                                      //         if(datashot.data?["savedPosts"].contains(snapshot.data?.docs[index]["postuid"])){
                                      //           return InkWell(
                                      //             onTap: () async {
                                      //               await _firestore
                                      //                   .collection("userProfile")
                                      //                   .doc(FirebaseAuth.instance.currentUser?.uid)
                                      //                   .update({
                                      //                 "savedPosts": FieldValue.arrayRemove([snapshot.data?.docs[index]["postuid"]])});
                                      //               ScaffoldMessenger.of(context).showSnackBar(
                                      //                   const SnackBar(
                                      //                       content:
                                      //                       Text('Item removed from wishlist 💔')));
                                      //
                                      //             },
                                      //             child: Container(
                                      //                 height: 25,
                                      //                 width: 25,
                                      //                 decoration: BoxDecoration(
                                      //                     boxShadow: [
                                      //                       BoxShadow(
                                      //                           color: Colors.grey,
                                      //                           blurRadius: 5.0
                                      //                       )
                                      //                     ],
                                      //                     color: Colors.white,
                                      //                     borderRadius: BorderRadius.all(Radius.circular(100))
                                      //                 ),
                                      //                 child: Center(
                                      //                     child: SvgPicture
                                      //                         .asset('assets/Heart.svg'))
                                      //
                                      //               // ElevatedButton(onPressed: () async {
                                      //               //       await _firestore
                                      //               //           .collection("userProfile")
                                      //               //           .doc(FirebaseAuth.instance.currentUser?.uid)
                                      //               //           .update({
                                      //               //       "savedPosts": FieldValue.arrayRemove([snapshot.data?.docs[index]["postuid"]])});
                                      //               //   // if(datashot.data?["savedPosts"].contains(snapshot.data?.docs[index]["postuid"])){
                                      //               //   //   print("object");
                                      //               //   // }
                                      //               //   // else{
                                      //               //   //   print("no data");
                                      //               //   // }
                                      //               // }, child: Text("LIKEd")),
                                      //             ),
                                      //           );
                                      //         }
                                      //         return InkWell(
                                      //           onTap: () async {
                                      //             await _firestore
                                      //                 .collection("userProfile")
                                      //                 .doc(FirebaseAuth.instance.currentUser?.uid)
                                      //                 .update({
                                      //               "savedPosts": FieldValue.arrayUnion([snapshot.data?.docs[index]["postuid"]])});
                                      //             ScaffoldMessenger.of(context).showSnackBar(
                                      //                 const SnackBar(
                                      //                     content: Text('Item added to wishlist ❤')));
                                      //
                                      //           },
                                      //           child: Container(
                                      //               height: 25,
                                      //               width: 25,
                                      //               decoration: BoxDecoration(
                                      //                   boxShadow: [
                                      //                     BoxShadow(
                                      //                         color: Colors.grey,
                                      //                         blurRadius: 5.0
                                      //                     )
                                      //                   ],
                                      //                   color: Colors.white,
                                      //                   borderRadius: BorderRadius.all(Radius.circular(100))
                                      //               ),
                                      //               child: Center(
                                      //                   child: SvgPicture
                                      //                       .asset('assets/EHeart.svg'))
                                      //
                                      //             // ElevatedButton(onPressed: () async {
                                      //             //       await _firestore
                                      //             //           .collection("userProfile")
                                      //             //           .doc(FirebaseAuth.instance.currentUser?.uid)
                                      //             //           .update({
                                      //             //       "savedPosts": FieldValue.arrayRemove([snapshot.data?.docs[index]["postuid"]])});
                                      //             //   // if(datashot.data?["savedPosts"].contains(snapshot.data?.docs[index]["postuid"])){
                                      //             //   //   print("object");
                                      //             //   // }
                                      //             //   // else{
                                      //             //   //   print("no data");
                                      //             //   // }
                                      //             // }, child: Text("LIKEd")),
                                      //           ),
                                      //         );
                                      //       }
                                      //       // var data = snapshot.data?.data();
                                      //       // if (data?['savedPosts'].contains(["XNva3nhXjVThMD5MkJyG"])){
                                      //       //   liked = true;
                                      //       //   print(liked);
                                      //
                                      //       // }
                                      //       else  {
                                      //         return
                                      //           ElevatedButton(onPressed: (){
                                      //             print(datashot.data?[index] ["savedPosts"]);
                                      //           }, child: Text("No DATA"));
                                      //       }
                                      //       // return const SizedBox(child: Text("apsdo"),);
                                      //     },
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data?.docs[index]
                                ["title"] ??
                                    "",
                                style: const TextStyle(
                                    color: Colors.grey),
                              ),
                              Text(
                                '\$${snapshot.data?.docs[index]["cost"]}' ??
                                    "",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              // SizedBox(
                              //   height: 30,
                              //   width: 100,
                              //   child: ElevatedButton(
                              //       style: ButtonStyle(
                              //           shape: MaterialStateProperty.all(
                              //               const RoundedRectangleBorder(
                              //                   borderRadius:
                              //                   BorderRadius.all(
                              //                       Radius.circular(
                              //                           50)))),
                              //           backgroundColor:
                              //           MaterialStateProperty
                              //               .all(const Color(
                              //               0xffFD8A00))),
                              //       onPressed: () {
                              //         snapshot.data?.docs[index]["savedPosts"].forEach((post) {
                              //           print(post);
                              //         });
                              //       },
                              //       child: const Text(
                              //         "Add to Card",
                              //         style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 12),
                              //       )),
                              // ),


                            ],
                          ),
                        );
                      }),
                );
              } else {
                return const Center(child: Text("No Data"));
              }
            }),
      )
    );
  }
}
