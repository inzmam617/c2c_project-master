import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../AllPosts/ProductDetails/ProductDetails.dart';

class mywishlist extends StatefulWidget {
  const mywishlist({Key? key}) : super(key: key);

  @override
  State<mywishlist> createState() => _mywishlistState();
}

class _mywishlistState extends State<mywishlist> {
  bool like = false;

  String? field;

  final _firestore = FirebaseFirestore.instance;
  List psot = ["0"];
  var p;
  // Future<List> getAllPosts() async {
  //   QuerySnapshot querySnapshot = await _firestore
  //       .collection('Posts')
  //       .where('savedPosts', arrayContains: psot)
  //       .orderBy('time', descending: true)
  //       .get();
  //
  //   List posts = [];
  //   querySnapshot.docs.forEach((doc) {
  //     posts.add(post.fromFirestore(doc));
  //   });
  // }

    // return posts;
  getStream() {
    if(psot.isNotEmpty){
      return _firestore
          .collection('Posts').where(FieldPath.documentId , whereIn: psot)
      // .where('savedPosts', arrayContains: ["UZt0sQZlJ8UZw7g2LVyC" ,"xBkJ5GMnFzAYNMN5LGeu"])
      // .orderBy('time', descending: true)
          .snapshots();
    }
    else{
      return null;
    }

  }
  getsStream() {
    return _firestore
        .collection('Posts')
        // .doc("LIST HERE")
        // .where('savedPosts',
        //     arrayContains: psot)
        .snapshots();
  }
  String? title;
  String? cost;
  String? imageUrl;
  String? category;
  String? brand;
  String? color;
  String? fabric;
  String? pattern;
  String? description;
  String? owner;
  String? condition;
  String? uID;
  String? address;
  List<String>? images;
  String? docID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: const Text(
            "My Wishlist",
            style: TextStyle(fontSize: 18, color: Color(0xff020203)),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance.collection("userProfile").doc(FirebaseAuth.instance.currentUser?.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> datashot) {
            if(datashot.hasData){
              psot = datashot.data["savedPosts"];
              // print(psot);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: getStream(),
                    builder: (context, snapshot) {
                      if(snapshot.hasError){
                        return Center(child: Text(snapshot.error.toString()),);
                      }
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
                                            children: [
                                              Transform.translate(
                                                offset: const Offset(
                                                    -10, 10),
                                                child:        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                                  stream: FirebaseFirestore.instance
                                                      .collection('userProfile')
                                                      .doc(FirebaseAuth.instance.currentUser?.uid)
                                                      .snapshots(),
                                                  builder: (context, datashot) {
                                                    if (datashot.hasData) {
                                                      if(datashot.data?["savedPosts"].contains(snapshot.data?.docs[index]["postuid"])){
                                                        return InkWell(
                                                          onTap: () async {
                                                            await _firestore
                                                                .collection("userProfile")
                                                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                                                .update({
                                                              "savedPosts": FieldValue.arrayRemove([snapshot.data?.docs[index]["postuid"]])});
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                const SnackBar(
                                                                    content:
                                                                    Text('Item removed from wishlist 💔')));

                                                          },
                                                          child: Container(
                                                              height: 25,
                                                              width: 25,
                                                              decoration: const BoxDecoration(
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors.grey,
                                                                        blurRadius: 5.0
                                                                    )
                                                                  ],
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.all(Radius.circular(100))
                                                              ),
                                                              child: Center(
                                                                  child: SvgPicture
                                                                      .asset('assets/Heart.svg'))
                                                          ),
                                                        );
                                                      }
                                                      return InkWell(
                                                        onTap: () async {
                                                          await _firestore
                                                              .collection("userProfile")
                                                              .doc(FirebaseAuth.instance.currentUser?.uid)
                                                              .update({
                                                            "savedPosts": FieldValue.arrayUnion([snapshot.data?.docs[index]["postuid"]])});
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(
                                                                  content: Text('Item added to wishlist ❤')));

                                                        },
                                                        child: Container(
                                                            height: 25,
                                                            width: 25,
                                                            decoration: const BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Colors.grey,
                                                                      blurRadius: 5.0
                                                                  )
                                                                ],
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.all(Radius.circular(100))
                                                            ),
                                                            child: Center(
                                                                child: SvgPicture
                                                                    .asset('assets/EHeart.svg'))

                                                          // ElevatedButton(onPressed: () async {
                                                          //       await _firestore
                                                          //           .collection("userProfile")
                                                          //           .doc(FirebaseAuth.instance.currentUser?.uid)
                                                          //           .update({
                                                          //       "savedPosts": FieldValue.arrayRemove([snapshot.data?.docs[index]["postuid"]])});
                                                          //   // if(datashot.data?["savedPosts"].contains(snapshot.data?.docs[index]["postuid"])){
                                                          //   //   print("object");
                                                          //   // }
                                                          //   // else{
                                                          //   //   print("no data");
                                                          //   // }
                                                          // }, child: Text("LIKEd")),
                                                        ),
                                                      );
                                                    }
                                                    // var data = snapshot.data?.data();
                                                    // if (data?['savedPosts'].contains(["XNva3nhXjVThMD5MkJyG"])){
                                                    //   liked = true;
                                                    //   print(liked);

                                                    // }
                                                    else  {
                                                      return
                                                        ElevatedButton(onPressed: (){
                                                          print(datashot.data?[index] ["savedPosts"]);
                                                        }, child: const Text("No DATA"));
                                                    }
                                                    // return const SizedBox(child: Text("apsdo"),);
                                                  },
                                                ),
                                              ),
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
                        return  Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assests/Heart.svg"),
                              const SizedBox(height: 20,),
                              const Text("No Products Found!"),
                            ],
                          ),
                        );
                      }
                    }),
              );

            }
            else{
              return const Center(child: Text("..."),);
            }

        },
        ));
  }
}
