import 'dart:async';
import 'package:c2c_project1/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/item_view_card.dart';
import '../components/profile_generator.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SavedPosts extends StatefulWidget {
  const SavedPosts({Key? key}) : super(key: key);

  @override
  State<SavedPosts> createState() => _SavedPostsState();
}

class _SavedPostsState extends State<SavedPosts> {
  int count = 0;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    List<ItemCardView> draftItems = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("userProfile")
              .doc(user?.uid)
              .get(),
          builder: (context, dataShot) {
            if (dataShot.hasData) {
              try {
                var posts = dataShot.data?.get("savedPosts");
                //print(posts);

                if (count == 0) {
                  Future.delayed(const Duration(microseconds: 1))
                      .whenComplete(() {
                    setState(() {});
                  });
                  count += 1;
                }

                for (var post in posts) {
                  var p = firestore.collection('Posts').doc(post).snapshots();

                  p.forEach((element) async {
                    var userData = await FirebaseFirestore.instance
                        .collection("userProfile")
                        .doc(user?.uid)
                        .get();
                    savedPostsList = userData.get('savedPosts');
                    draftItems.add(
                      ItemCardView(
                        title: element.data()!['title'],
                        cost: element.data()!['cost'].toString(),
                        imageUrl: element.data()!['images'][0],
                        category: element.data()!['productCategory'],
                        brand: element.data()!['brand'],
                        color: element.data()!['color'],
                        fabric: element.data()!['fabric'],
                        pattern: element.data()!['pattern'],
                        description: element.data()!['description'],
                        owner: element.data()!['postedBy'],
                        condition: element.data()!['materialCondition'],
                        uID: element.data()!['uID'],
                        address: element.data()!['address'],
                        images: List<String>.from(element.data()!['images']),
                        onSale: element.data()!['onSale'],
                        docID: element.id,
                        savedPost:
                            savedPostsList.contains(element.id) ? true : false,
                        postedOn: element.data()!['time'],
                      ),
                    );
                  });
                }
                return MasonryGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  itemCount: draftItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return draftItems[index];
                  },
                );
              } catch (e) {
                return const Center(
                  child: Text('No products found!'),
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
