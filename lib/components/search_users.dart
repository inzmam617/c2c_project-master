import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../screens/profile.dart';
import 'onSaleLayout.dart';

class SearchUsers extends StatefulWidget {
  final String search;
  const SearchUsers({Key? key, required this.search}) : super(key: key);

  @override
  State<SearchUsers> createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  final _firestore = FirebaseFirestore.instance;
  late double rating;

  ratingAlert(String username, String uid) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Rate $username!'),
        content: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.04,
              child: Center(
                child: RatingBar(
                    itemSize: 40.0,
                    initialRating: 0,
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
                    onRatingUpdate: (value) async {
                      setState(() {
                        rating = value;
                      });
                    }),
              ),
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              setState(() {
                search = '';
              });
              if (uid == user?.uid) {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You cannot rate yourself!')));
              } else {
                await _firestore.collection('userProfile').doc(uid).update({
                  "rating.$rating": FieldValue.increment(1),
                });

                Navigator.of(ctx).pop();
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('You rated $username as $rating 🌟')));
              }
            },
            child: const Text("Rate"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('userProfile').snapshots(),
      builder: (context, snapshots) {
        try {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data?.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                    if (widget.search.isEmpty) {
                      return TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setState(() {
                            FocusScope.of(context).unfocus();
                          });
                          ratingAlert(data['username'], data['uid']);
                        },
                        child: ListTile(
                          title: Text(
                            data['username'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            data['email'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          leading: ProfilePicture(
                            name: data['username'],
                            radius: 20.0,
                            fontsize: 10.0,
                          ),
                        ),
                      );
                    }

                    if (data['username']
                        .toString()
                        .toLowerCase()
                        .startsWith(widget.search.toLowerCase())) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            FocusScope.of(context).unfocus();
                          });
                          ratingAlert(data['username'], data['uid']);
                        },
                        child: ListTile(
                          title: Text(
                            data['username'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['email'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: ProfilePicture(
                            name: data['username'],
                            radius: 20.0,
                            fontsize: 10.0,
                          ),
                        ),
                      );
                    }
                    return Container();
                  });
        } catch (e) {
          print(e);
        }
        return Container();
      },
    );
  }
}
