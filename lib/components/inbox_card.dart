import 'package:c2c_project1/screens/chat_screen.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

final _firestore = FirebaseFirestore.instance;
String toBeUsedID = '';
String toBeContactedUser = '';
String searchUser = '';

class InboxChats extends StatefulWidget {
  const InboxChats({Key? key}) : super(key: key);

  @override
  State<InboxChats> createState() => _InboxChatsState();
}

class _InboxChatsState extends State<InboxChats> {
  checkIfProfilePicExists(uName, pPic) {
    if (pPic == '') {
      return ProfilePicture(
        name: uName,
        radius: 30.0,
        fontsize: 15.0,
      );
    } else {
      return ProfilePicture(
        name: uName,
        radius: 30.0,
        fontsize: 15.0,
        img: pPic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("Messages")
            .doc(user?.uid)
            .collection("Users")
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            final snaps = snapshots.data?.docs;

            List<TextButton> list = [];

            for (var i in snaps!) {
              list.add(
                TextButton(
                  onPressed: () {
                    toBeUsedID = i['uID'];
                    toBeContactedUser = i['userName'];

                    _firestore
                        .collection('userProfile')
                        .doc(user?.uid)
                        .update({'chattingWith': toBeUsedID});

                    Navigator.of(context, rootNavigator: true).push(
                      // ensures fullscreen
                      CupertinoPageRoute(
                        builder: (BuildContext context) {
                          return ChatScreen(
                            user1: user?.uid,
                            user2: toBeUsedID,
                          );
                        },
                      ),
                    );
                  },
                  child: ListTile(
                      title: Text(
                        i['userName'],
                      ),
                      contentPadding:
                          const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                      leading: checkIfProfilePicExists(
                          i['userName'], i['userProfile'])),
                ),
              );
            }
            return ListView(
              shrinkWrap: true,
              children: list,
            );
          }

          return Container();
        });
  }
}
