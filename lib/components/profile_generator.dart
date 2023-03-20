import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/chat_screen.dart';
import '../screens/edit_profile.dart';
import '../screens/profile.dart';
import 'item_view_card.dart';

List<dynamic> savedPostsList = [];

class ProfileViewGenerator extends StatelessWidget {
  const ProfileViewGenerator({Key? key, required this.id}) : super(key: key);

  final String? id;

  @override
  Widget build(BuildContext context) {
    double avgRating = 0;
    final firestore = FirebaseFirestore.instance;

    createChatRoomID(u1, u2) {
      if (u1[0]?.toLowerCase().codeUnits[0] > u2.toLowerCase().codeUnits[0]) {
        return '$u1$u2';
      } else {
        return '$u2$u1';
      }
    }

    ifSaved() async {
      try {
        var userData = await FirebaseFirestore.instance
            .collection("userProfile")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();

        savedPostsList = userData.get('savedPosts');
      } catch (e) {
        print(e);
      }
    }

    return ListView(
      children: [
        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: firestore.collection("userProfile").doc(id).get(),
          builder: (context, dataShot) {
            if (dataShot.hasData) {
              var userName = dataShot.data?.get("username");
              var profilePicture = dataShot.data?.get("profilePicture");
              //var about = dataShot.data?.get("aboutSection");
              var myID = dataShot.data?.get("uid");
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

              // print('AVG: $avgRating, $userName');

              if (avgRating.isNaN) {
                avgRating = 0;
              }

              checkIfProfile() {
                if (profilePicture == '') {
                  return ProfilePicture(
                    name: userName,
                    radius: 100.0,
                    fontsize: 21.0,
                  );
                } else {
                  return ProfilePicture(
                    name: userName,
                    radius: 100.0,
                    fontsize: 60.0,
                    img: profilePicture,
                  );
                }
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.01),
                    child: checkIfProfile(),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            userName,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                      // Text(
                      //   about,
                      //   style: TextStyle(
                      //       fontSize: MediaQuery.of(context).size.width * 0.03,
                      //       color: Colors.black54),
                      // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      RatingBar(
                        itemSize: MediaQuery.of(context).size.width * 0.05,
                        ignoreGestures: true,
                        initialRating: avgRating,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                            full: const Icon(Icons.star, color: Colors.yellow),
                            half: const Icon(
                              Icons.star_half,
                              color: Colors.yellow,
                            ),
                            empty: const Icon(
                              Icons.star_outline,
                              color: Colors.yellow,
                            )),
                        onRatingUpdate: (double value) {},
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (user?.uid == myID) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Hey! That\'s you.'),
                                ),
                              );
                            } else {
                              try {
                                await firestore
                                    .collection("Messages")
                                    .doc(user?.uid)
                                    .collection("Users")
                                    .doc(createChatRoomID(
                                        user?.uid, productUserID))
                                    .set({
                                  'userName': userName,
                                  'uID': productUserID,
                                  'userProfile': profilePicture,
                                  'time': FieldValue.serverTimestamp(),
                                });

                                await firestore
                                    .collection("Messages")
                                    .doc(productUserID)
                                    .collection("Users")
                                    .doc(createChatRoomID(
                                        user?.uid, productUserID))
                                    .set({
                                  'userName': editUsername,
                                  'uID': user?.uid,
                                  'userProfile': editProfile,
                                  'time': FieldValue.serverTimestamp(),
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            user1: user?.uid,
                                            user2: productUserID,
                                          )),
                                );
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                          child: const Text('Message'))
                    ],
                  ),
                ],
              );
            }
            return Container();
          },
        ),
        StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('Posts')
              .where('uID', isEqualTo: id)
              .snapshots(),
          builder: (context, snapshot) {
            try {
              final posts = snapshot.data?.docs;

              ifSaved();

              List<ItemCardView> draftItems = [];

              for (var post in posts!) {
                draftItems.add(
                  ItemCardView(
                    title: post['title'],
                    cost: post['cost'].toString(),
                    imageUrl: post['images'][0],
                    category: post['productCategory'],
                    brand: post['brand'],
                    color: post['color'],
                    fabric: post['fabric'],
                    pattern: post['pattern'],
                    description: post['description'],
                    owner: post['postedBy'],
                    condition: post['materialCondition'],
                    uID: post['uID'],
                    address: post['address'],
                    images: List<String>.from(post['images']),
                    onSale: post['onSale'],
                    docID: post.id,
                    savedPost: savedPostsList.contains(post.id) ? true : false,
                    postedOn: post['time'],
                  ),
                );
              }
              return MasonryGridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: draftItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return draftItems[index];
                },
              );
            } catch (e) {
              // print(e); //fix this exception at the later stage!!!
            }

            return Container();
          },
        ),
      ],
    );
  }
}
