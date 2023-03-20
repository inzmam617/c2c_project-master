import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import '../screens/profile.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  sendMessage() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
  }

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('Registration Token=$token');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Messages")
            .doc(user?.uid)
            .collection("Notifications")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snaps = snapshot.data?.docs;

            List<TextButton> notifications = [];

            for (var snap in snaps!) {
              notifications.add(
                TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  onPressed: () {},
                  child: ListTile(
                    tileColor: Colors.white12,
                    leading: ProfilePicture(
                      name: '',
                      radius: 30.0,
                      fontsize: 10.0,
                      img: snap.get('productPicture'),
                    ),
                    title: Text(snap.get('content')),
                    subtitle: const Text('Click to open the conversation!'),
                  ),
                ),
              );
            }

            return ListView(
              children: notifications,
            );
          }
          return Container();
        });
  }
}
