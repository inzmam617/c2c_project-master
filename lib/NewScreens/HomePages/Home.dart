import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../bottom_icons_icons.dart';
import '../../screens/profile.dart';
import '../AllPosts/ProductDetails/ProductDetails.dart';
import '../Cart/CartPage.dart';
import '../FilterPage/FilterPage.dart';
import '../Message&Notification/TabBar.dart';
import '../MyCloset/MyClosetPage.dart';
import '../Post/PostPage.dart';
import '../ProfilePage/ProfilePage.dart';

bool value = false;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus('Online');
  }
  void setStatus(String status) async {
    await _firestore.collection('userProfile').doc(user?.uid).update({
      "status": status,
    });
  }

  String? field;



  List pages = const [
     HomePage(),
     CartPage(),
     PostPage(),
     MyClosetPage(),
     ProfilePage(),
  ];
  int currentIndex = 0;
  bool? liked ;
  void _onItemTapped(int Index) {
    setState(() {
      currentIndex = Index;
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return pages[Index];
    }));
    print(Index);
  }

  // List dress = [
  //   "one.jpg",
  //   "two.jpg",
  //   "three.jpg",
  //   "four.jpg",
  //   "five.jpg",
  //   "six.jpg",
  //   "seven.jpg",
  //   "eight.jpg",
  //   "dressNine.png"
  // ];
  // List dresstwo = [
  //   "one.jpg",
  //   "two.jpg",
  //   "three.jpg",
  //   "four.jpg",
  //   "five.jpg",
  //   "six.jpg",
  //   "seven.jpg",
  //   "eight.jpg",
  //   "dressSeven.png",
  //   "dressEight.png",
  //   "dressNine.png"
  // ];
  bool like = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                ),
              ],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
            ),
            margin: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: Container(
                        //padding: const EdgeInsets.all(7),
                        child: const Icon(
                      Icons.home_filled,
                      //color: Colors.grey,
                    )),
                    //label: '',
                  ),
                  BottomNavigationBarItem(
                    label: "Chat",
                    icon: Container(
                        //padding: const EdgeInsets.all(7),
                        child: const Icon(BottomIcons.buy
                            // color: Colors.grey,
                            )),
                    //label: '',
                  ),
                  BottomNavigationBarItem(
                    label: "Post",
                    icon: Container(
                        //padding: const EdgeInsets.all(7),
                        child: const Icon(BottomIcons.camera
                            //  color: Colors.grey,
                            )),
                  ),
                  BottomNavigationBarItem(
                    label: "My Closet",
                    icon: Container(
                        //padding: const EdgeInsets.all(7),
                        child: const Icon(BottomIcons.iconly_light_bag
                            //  color: Colors.grey,
                            )),
                    //label: '',
                  ),
                  BottomNavigationBarItem(
                    label: "Account",
                    icon: Container(
                        //padding: const EdgeInsets.all(7),
                        child: const Icon(BottomIcons.profile
                            // color: Colors.grey,
                            )),
                    //label: '',
                  ),
                ],
                currentIndex: 0,
                selectedIconTheme:
                    const IconThemeData(color: Color(0xffFD8A00), size: 25),
                unselectedIconTheme:
                    const IconThemeData(color: Colors.grey, size: 20),
                selectedItemColor: const Color(0xffFD8A00),
                unselectedItemColor: Colors.grey,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                onTap: _onItemTapped,
                selectedFontSize: 9,
                unselectedFontSize: 8,
                type: BottomNavigationBarType.fixed,
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xffFD8A00),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Transform.translate(
                  offset: const Offset(-55, -90),
                  child: SvgPicture.asset("assets/BigCircle.svg")),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: SvgPicture.asset("assets/BigCircle.svg")),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      // Container(
                      //   decoration: const BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(100))),
                      //   width: 40,
                      //   height: 40,
                      //   child: Center(
                      //     child: SvgPicture.asset("assets/menu.svg"),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const TabBarPage();
                          }));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          width: 40,
                          height: 40,
                          child: Center(
                            child: SvgPicture.asset("assets/Chat.svg"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width - 100,
                        height: 45,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              //contentPadding: EdgeInsets.only(left: 35),
                              border: InputBorder.none,
                              hintText: "Search Now",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const FilterPage();
                          }));
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          width: 45,
                          height: 45,
                          child: Center(
                            child: SvgPicture.asset("assets/settings.svg"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    //height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "All Products",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                SizedBox()
                              ],
                            ),
                          ),


                          StreamBuilder<QuerySnapshot>(
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


                                                                  ),
                                                                );
                                                              }

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
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          shape: MaterialStateProperty.all(
                                                              const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              50)))),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(const Color(
                                                                      0xffFD8A00))),
                                                      onPressed: () {
                                                              print( snapshot.data?.docs[index]["archive"]);
                                                        FirebaseFirestore.instance.collection('Posts').doc(snapshot.data?.docs[index]["postuid"]).update(
                                                            {
                                                              "archive" : "yes"
                                                            });
                                                              ScaffoldMessenger.of(context)
                                                                  .showSnackBar(SnackBar(
                                                                content: Text("Item Added to Archive"),
                                                              ));
                                                            // .where('archive', isEqualTo: 'no')
                                                            // .orderBy('time', descending: true)

                                                      },
                                                      child: const Text(
                                                        "Add to Card",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      )),
                                                ),


                                              ],
                                            ),
                                          );
                                        }),
                                  );
                                } else {
                                  return const Center(child: Text("No Data"));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
// StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
// stream: FirebaseFirestore.instance
//     .collection('userProfile')
// .doc(FirebaseAuth.instance.currentUser?.uid)
// .snapshots(),
// builder: (context, datashot) {
// if (datashot.hasData) {
// if(datashot.data?["savedPosts"].contains(snapshot.data?.docs[index]["postuid"])){
// return InkWell(
// onTap: () async {
// await _firestore
//     .collection("userProfile")
//     .doc(FirebaseAuth.instance.currentUser?.uid)
//     .update({
// "savedPosts": FieldValue.arrayRemove([snapshot.data?.docs[index]["postuid"]])});
// ScaffoldMessenger.of(context).showSnackBar(
// const SnackBar(
// content:
// Text('Item removed from wishlist 💔')));
//
// },
// child: Container(
// height: 20,
// width: 20,
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.grey,
// blurRadius: 5.0
// )
// ],
// color: Colors.white,
// borderRadius: BorderRadius.all(Radius.circular(100))
// ),
// child: Center(
// child: SvgPicture
//     .asset('assets/Heart.svg'))
//
// // ElevatedButton(onPressed: () async {
// //       await _firestore
// //           .collection("userProfile")
// //           .doc(FirebaseAuth.instance.currentUser?.uid)
// //           .update({
// //       "savedPosts": FieldValue.arrayRemove([snapshot.data?.docs[index]["postuid"]])});
// //   // if(datashot.data?["savedPosts"].contains(snapshot.data?.docs[index]["postuid"])){
// //   //   print("object");
// //   // }
// //   // else{
// //   //   print("no data");
// //   // }
// // }, child: Text("LIKEd")),
// ),
// );
// }
// return InkWell(
// onTap: () async {
// await _firestore
//     .collection("userProfile")
//     .doc(FirebaseAuth.instance.currentUser?.uid)
//     .update({
// "savedPosts": FieldValue.arrayUnion([snapshot.data?.docs[index]["postuid"]])});
// ScaffoldMessenger.of(context).showSnackBar(
// const SnackBar(
// content: Text('Item added to wishlist ❤')));
//
// },
// child: Container(
// height: 20,
// width: 20,
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.grey,
// blurRadius: 5.0
// )
// ],
// color: Colors.white,
// borderRadius: BorderRadius.all(Radius.circular(100))
// ),
// child: Center(
// child: SvgPicture
//     .asset('assets/EHeart.svg'))
//
// // ElevatedButton(onPressed: () async {
// //       await _firestore
// //           .collection("userProfile")
// //           .doc(FirebaseAuth.instance.currentUser?.uid)
// //           .update({
// //       "savedPosts": FieldValue.arrayRemove([snapshot.data?.docs[index]["postuid"]])});
// //   // if(datashot.data?["savedPosts"].contains(snapshot.data?.docs[index]["postuid"])){
// //   //   print("object");
// //   // }
// //   // else{
// //   //   print("no data");
// //   // }
// // }, child: Text("LIKEd")),
// ),
// );
// }
// // var data = snapshot.data?.data();
// // if (data?['savedPosts'].contains(["XNva3nhXjVThMD5MkJyG"])){
// //   liked = true;
// //   print(liked);
//
// // }
// else  {
// return
// ElevatedButton(onPressed: (){
// print(datashot.data?[index] ["savedPosts"]);
// }, child: Text("No DATA"));
// }
// // return const SizedBox(child: Text("apsdo"),);
// },
// ),