import 'package:c2c_project1/components/saved_button.dart';
import 'package:c2c_project1/screens/chat_screen.dart';
import 'package:c2c_project1/screens/home_screen.dart';
import 'package:c2c_project1/screens/users_profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:share_plus/share_plus.dart';
import '../components/item_view_card.dart';
import 'package:flutter/material.dart';
import 'edit_profile.dart';

late String referenceUser;

class ProductDisplay extends StatefulWidget {
  const ProductDisplay({Key? key}) : super(key: key);

  @override
  State<ProductDisplay> createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  final _firestore = FirebaseFirestore.instance;

  bool showSpinner = false;
  String rUserName = '';
  String rUID = '';
  String rProfilePicture = '';
  String rEmail = '';
  String rAbout = '';
  late double avgRating = 0;

  createChatRoomID(u1, u2) {
    if (u1[0]?.toLowerCase().codeUnits[0] > u2.toLowerCase().codeUnits[0]) {
      return '$u1$u2';
    } else {
      return '$u2$u1';
    }
  }

  bool saved = savedPost;

  getPostedTime() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
          'Active Since: ${postDate.toDate().day}-${postDate.toDate().month}-${postDate.toDate().year}'),
    );
  }

  @override
  void initState() {
    saved;
    savedPost;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: ListView(
          children: [
            CarouselSlider.builder(
              itemCount: productImages.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return Container(
                  height: 600.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(productImages[itemIndex]),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Share.share(
                                    'Check out this $productDisplayTitle on xCLoset!',
                                    subject: 'Look what I saw!');
                              },
                              child: const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                        SaveButton(
                            ifSaved: saved, uID: productID, iconSize: 35.0)
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                enableInfiniteScroll: false,
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 0.65,
                initialPage: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productDisplayTitle,
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$$productDisplayCost',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 30.0,
                      ),
                      Expanded(
                        child: Text(
                          productUserAddress,
                          maxLines: 3,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Text(
                    "Seller Rating: ",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: _firestore
                          .collection("userProfile")
                          .doc(productUserID)
                          .get(),
                      builder: (context, dataShot) {
                        if (dataShot.hasData) {
                          var rating = dataShot.data?.get("rating");
                          avgRating = (rating['1']['0'] * 1 +
                                  rating['2']['0'] * 2 +
                                  rating['3']['0'] * 3 +
                                  rating['4']['0'] * 4 +
                                  rating['5']['0'] * 5) /
                              (rating['1']['0'] +
                                  rating['2']['0'] +
                                  rating['3']['0'] +
                                  rating['4']['0'] +
                                  rating['5']['0']);

                          if (avgRating.isNaN) {
                            avgRating = 0;
                          }

                          return RatingBar(
                            itemSize: MediaQuery.of(context).size.width * 0.08,
                            ignoreGestures: true,
                            initialRating: avgRating,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                                full: const Icon(Icons.star,
                                    color: Colors.yellow),
                                half: const Icon(
                                  Icons.star_half,
                                  color: Colors.yellow,
                                ),
                                empty: const Icon(
                                  Icons.star_outline,
                                  color: Colors.yellow,
                                )),
                            onRatingUpdate: (double value) {},
                          );
                        }

                        return Container();
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            getPostedTime(),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Product Specifications: ",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Product Category: ",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        productDisplayCategory,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Brand Name: ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                          fontSize: 17.0,
                        ),
                      ),
                      Text(
                        productDisplayBrand,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Cloth Condition: ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                          fontSize: 17.0,
                        ),
                      ),
                      Text(
                        productDisplayCondition,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Color: ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                          fontSize: 17.0,
                        ),
                      ),
                      Text(
                        productDisplayColor,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Fabric: ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                          fontSize: 17.0,
                        ),
                      ),
                      Text(
                        productDisplayFabric,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Pattern: ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                          fontSize: 17.0,
                        ),
                      ),
                      Text(
                        productDisplayPattern,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Product Description: ",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  productDisplayDescription,
                  style: const TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Product Posted By: ",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future:
                  _firestore.collection("userProfile").doc(productUserID).get(),
              builder: (context, dataShot) {
                if (dataShot.hasData) {
                  var userName = dataShot.data?.get("username");
                  rUserName = userName;

                  var profilePicture = dataShot.data?.get("profilePicture");
                  rProfilePicture = profilePicture;

                  var uID = dataShot.data?.get("uid");
                  rUID = uID;

                  var email = dataShot.data?.get('email');
                  rEmail = email;

                  return TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserProfile(username: rUserName, uID: rUID),
                        ),
                      );
                    },
                    child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        title: Text(rUserName),
                        leading: rProfilePicture != ''
                            ? ProfilePicture(
                                name: rUserName,
                                radius: 30.0,
                                fontsize: 15.0,
                                img: rProfilePicture,
                              )
                            : ProfilePicture(
                                name: rUserName,
                                radius: 30.0,
                                fontsize: 15.0,
                              ),
                        subtitle: Text(rAbout),
                        trailing: ElevatedButton(
                          onPressed: () async {
                            if (productOwner == user?.email) {
                              setState(() {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Hey! This is your own post!'),
                                ));
                              });
                            } else {
                              setState(() {
                                currentIndex = 1;
                              });
                              referenceUser = productUserID;
                              try {
                                await _firestore
                                    .collection("Messages")
                                    .doc(user?.uid)
                                    .collection("Users")
                                    .doc(createChatRoomID(
                                        user?.uid, referenceUser))
                                    .set({
                                  'userName': rUserName,
                                  'uID': referenceUser,
                                  'userProfile': rProfilePicture,
                                  'time': FieldValue.serverTimestamp(),
                                });

                                await _firestore
                                    .collection("Messages")
                                    .doc(referenceUser)
                                    .collection("Notifications")
                                    .add({
                                  'userName': editUsername,
                                  'uID': user?.uid,
                                  'productPicture': productDisplayImage,
                                  'time': FieldValue.serverTimestamp(),
                                  'content':
                                      '$editUsername is interested in $productDisplayTitle. ',
                                });

                                await _firestore
                                    .collection("Messages")
                                    .doc(referenceUser)
                                    .collection("Users")
                                    .doc(createChatRoomID(
                                        user?.uid, referenceUser))
                                    .set({
                                  'userName': editUsername,
                                  'uID': user?.uid,
                                  'userProfile': editProfile,
                                  'time': FieldValue.serverTimestamp(),
                                });

                                _firestore
                                    .collection('Messages')
                                    .doc(user?.uid)
                                    .collection('Users')
                                    .doc(createChatRoomID(
                                        user?.uid, referenceUser))
                                    .collection('Chats')
                                    .add({
                                  'text': productImages[0],
                                  'description': {
                                    'title': productDisplayTitle,
                                    'productDescription':
                                        productDisplayDescription,
                                    'category': productDisplayCategory,
                                  },
                                  'sender': user?.email,
                                  'type': 'imgTxt',
                                  'time': FieldValue.serverTimestamp(),
                                });
                                _firestore
                                    .collection('Messages')
                                    .doc(referenceUser)
                                    .collection('Users')
                                    .doc(createChatRoomID(
                                        user?.uid, referenceUser))
                                    .collection('Chats')
                                    .add(
                                  {
                                    'text': productImages[0],
                                    'description': {
                                      'title': productDisplayTitle,
                                      'productDescription':
                                          productDisplayDescription,
                                      'category': productDisplayCategory,
                                    },
                                    'sender': referenceUser,
                                    'type': 'imgTxt',
                                    'time': FieldValue.serverTimestamp(),
                                  },
                                );

                                setState(() {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(// ensures fullscreen
                                          CupertinoPageRoute(
                                              builder: (BuildContext context) {
                                    return ChatScreen(
                                      user1: user?.uid,
                                      user2: referenceUser,
                                    );
                                  }));
                                });

                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                          child: const Text('Message'),
                        )),
                  );
                }
                return Container();
              },
            ),
            Container(
              color: Colors.grey,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Buy Now",
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
