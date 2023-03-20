import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:math' as math;
import '../../bottom_icons_icons.dart';
import '../Ask us/askus.dart';
import '../Cart/CartPage.dart';
import '../Edit Profile/EditProfile.dart';
import '../Help/help.dart';
import '../HomePages/Home.dart';
import '../My Wishlist/mywishlist.dart';
import '../MyCloset/MyClosetPage.dart';
import '../Payment Details/carddetail.dart';
import '../Post/PostPage.dart';
import '../SignIn/SignIn.dart';
import '../ViewProfile/ViewProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List pages = [
    const HomePage(),
    const CartPage(),
    const PostPage(),
    const MyClosetPage(),
    const ProfilePage(),
  ];
  bool showSpinner = false;
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
                  //label: '',
                ),
              ],
              currentIndex: 4,
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
        backgroundColor: const Color(0xffFD8A00),
        elevation: 0.0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xffFD8A00),
                ),
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 5.0)
                        ],
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/eight.png")),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    height: 100,
                    width: 100,
                  ),
                ),
              ],
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const EditProfile();
                  }));
                },
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(color: Color(0xffFD8A00)),
                ),
              ),
            ),
            listtile("View Profile", "Profile",const ViewProfile()),
            listtile("My WishList", "YellowHeart",const mywishlist()),
            listtile("Manage Payments", "Wallet",const carddetail()),
            listtile("Got Questions? Ask us Here!", "More Square",const askus()),
            listtile("Help", "Info Square",const help()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  showSpinner = true;
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                    return SignIn();
                  }));
                  showSpinner = false;
                },
                child: Container(
                  height: 35,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2.5)]),
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/Logout.svg"),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("Logout")
                              ],
                            ),
                            Transform.rotate(
                              angle: 180 * math.pi / 180,
                              child: const Icon(Icons.arrow_back_ios_outlined),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ),
            // listtile("Logout", "Logout",const SignIn())
          ],
        ),
      ),
    );
  }

  Widget listtile(text, image, page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
         Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
           return page;
         }));
        },
        child: Container(
          height: 35,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2.5)]),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/$image.svg"),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(text)
                  ],
                ),
                Transform.rotate(
                  angle: 180 * math.pi / 180,
                  child: const Icon(Icons.arrow_back_ios_outlined),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
