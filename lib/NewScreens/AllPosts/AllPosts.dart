import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../bottom_icons_icons.dart';
import '../Cart/CartPage.dart';
import '../HomePages/Home.dart';
import '../Message&Notification/TabBar.dart';
import '../MyCloset/MyClosetPage.dart';
import '../Post/PostPage.dart';
import '../ProfilePage/ProfilePage.dart';
import 'ProductDetails/ProductDetails.dart';

final _firestore = FirebaseFirestore.instance;

class SeeAllPosts extends StatefulWidget {
  const SeeAllPosts({Key? key}) : super(key: key);

  @override
  State<SeeAllPosts> createState() => _SeeAllPostsState();
}

class _SeeAllPostsState extends State<SeeAllPosts> {
  String category = 'All';
  String fabric = 'All';
  String color = 'All';
  String occasion = 'All';
  String condition = 'All';
  String price = 'All';
  String sort = 'All';
  String size = 'All';
  String location = 'All';

  getStream() {
    return _firestore
        .collection('Posts')
        .where('archive', isEqualTo: 'no')
        .orderBy('time', descending: true)
        .snapshots();
  }

  List pages = [
    const HomePage(),
    const TabBarPage(),
    const PostPage(),
    const MyClosetPage(),
    const ProfilePage(),
  ];
  int currentIndex = 0;

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

  bool like = false;
  List dress = [
    "one.jpg",
    "two.jpg",
    "three.jpg",
    "four.jpg",
    "five.jpg",
    "six.jpg",
    "seven.jpg",
    "eight.jpg",
  ];

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
                    label: "Cart",
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
        appBar: AppBar(
          title: const Text("All  Post",style: TextStyle(color: Colors.black),),
          centerTitle: true,

          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: getStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio:
                              ((MediaQuery.of(context).size.width / 2) / 280),
                          crossAxisCount: 2),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return ProductDetails(
                                      details: snapshot.data?.docs[index],
                                    );
                                  }));
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  height: 170,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage((snapshot.data
                                                  ?.docs[index]["images"][0]) ??
                                              ""),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Transform.translate(
                                        offset: const Offset(-10, 10),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              like = !like;
                                            });
                                          },
                                          child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 5.0)
                                                  ],
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100))),
                                              child: like == true
                                                  ? Center(
                                                      child: SvgPicture.asset(
                                                          'assets/Heart.svg'))
                                                  : Center(
                                                      child: SvgPicture.asset(
                                                          'assets/EHeart.svg'))),
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
                                snapshot.data?.docs[index]["title"],
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                '\$${snapshot.data?.docs[index]["cost"]}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xffFD8A00))),
                                    onPressed: () {
                                      print(snapshot.data?.docs[index]);
                                    },
                                    child: const Text(
                                      "Add to Card",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )),
                              ),
                            ],
                          ),
                        );
                      });
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No Data"),
                  );
                }
                return const Center(
                  child: Text("No alaasd Data"),
                );

              }),
        ));
  }
}
