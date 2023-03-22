import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:c2c_project1/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:c2c_project1/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../components/inbox_card.dart';
import '../components/message_components.dart';
import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;
String txt1 = 'I want to buy it!';
String txt2 = 'Can we meet?';
bool visCheck = true;

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.user1,
    required this.user2,
  }) : super(key: key);

  final String? user1;
  final String user2;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  late String messageText;
  late String userStatus = '';
  late String userName = '';
  late String userProfile = '';
  File? imageFile;
  late String image;
  late File imageToBeSent;
  List<String> imgRef = [];

  createChatRoomID(u1, u2) {
    if (u1[0]?.toLowerCase().codeUnits[0] > u2.toLowerCase().codeUnits[0]) {
      return '$u1$u2';
    } else {
      return '$u2$u1';
    }
  }

  void sendPushNotifications(String token, String body, String title) async {
    try {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);

      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA1VQzn7M:APA91bF1eQWHZHE6oqvbCkiirYFG1HKfUGIxVa8MSC3mSCDLh4qW1woXhkXH7kZ-mshwjPfMv554pYqcX5B53XvZ6ExCCeV1bpnDsnhBy87VAYCpcZTgAY0iSbR2yQSdSRSNQsPcoY4L',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            "content_available": true,
            'data': <String, dynamic>{
              'click-action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
              "content_available": true,
            },
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
              'android_channel_id': 'xCloset',
            },
            'to': token,
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future getImage() async {
    ImagePicker picker = ImagePicker();

    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) async {
      if (value != null) {
        imageFile = File(value.path);

        final path = value.path;
        final fileName = Path.basename(path);
        image = fileName.toString();

        imageToBeSent = File(path);
        print(imageToBeSent);

        var ref = FirebaseStorage.instance
            .ref()
            .child('${user?.email}/${Path.basename(path)}');
        await ref.putFile(imageToBeSent).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            _firestore
                .collection('Messages')
                .doc(widget.user1)
                .collection('Users')
                .doc(createChatRoomID(widget.user1, widget.user2))
                .collection('Chats')
                .add({
              'text': value,
              'description': {},
              'sender': user?.email,
              'type': 'image',
              'time': FieldValue.serverTimestamp(),
            });
            _firestore
                .collection('Messages')
                .doc(widget.user2)
                .collection('Users')
                .doc(createChatRoomID(widget.user1, widget.user2))
                .collection('Chats')
                .add({
              'text': value,
              'description': {},
              'sender': toBeContactedUser,
              'type': 'image',
              'time': FieldValue.serverTimestamp(),
            });
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffFD8A00),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              print(widget.user2);
              _firestore
                  .collection('userProfile')
                  .doc(user?.uid)
                  .update({'chattingWith': null});
            },
          ),
          title: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future:
                FirebaseFirestore.instance.collection("userProfile").doc(widget.user2).get(),
            builder: (context, dataShot) {
              if (dataShot.hasData) {
                userName = dataShot.data?.get("username");
                userStatus = dataShot.data?.get("status");
                userProfile = dataShot.data?.get("profilePicture");

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      userStatus,
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  ],
                );
              }
              return const Text(
                '',
                style: TextStyle(fontSize: 10.0),
              );
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            MessagesStream(
              messageStream: _firestore
                  .collection('Messages')
                  .doc(user?.uid)
                  .collection('Users')
                  .doc(createChatRoomID(widget.user1, widget.user2))
                  .collection('Chats')
                  .orderBy('time', descending: false)
                  .snapshots(),
            ),
            Visibility(
              visible: visCheck,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.02),
                      child: RoundedButton(
                        title: txt1,
                        color: Colors.white,
                        onPressed: () {
                          messageText = txt1;
                          _firestore
                              .collection('Messages')
                              .doc(widget.user1)
                              .collection('Users')
                              .doc(createChatRoomID(widget.user1, widget.user2))
                              .collection('Chats')
                              .add({
                            'text': messageText,
                            'description': {},
                            'sender': user?.email,
                            'type': 'text',
                            'time': FieldValue.serverTimestamp(),
                          });
                          _firestore
                              .collection('Messages')
                              .doc(widget.user2)
                              .collection('Users')
                              .doc(createChatRoomID(widget.user1, widget.user2))
                              .collection('Chats')
                              .add({
                            'text': messageText,
                            'description': {},
                            'sender': toBeContactedUser,
                            'type': 'text',
                            'time': FieldValue.serverTimestamp(),
                          });

                          _firestore
                              .collection("Messages")
                              .doc(user?.uid)
                              .collection("Users")
                              .doc(createChatRoomID(widget.user1, widget.user2))
                              .update({
                            'time': FieldValue.serverTimestamp(),
                          });

                          _firestore
                              .collection("Messages")
                              .doc(widget.user2)
                              .collection("Users")
                              .doc(createChatRoomID(widget.user1, widget.user2))
                              .update({
                            'time': FieldValue.serverTimestamp(),
                          });

                          setState(() {
                            if (txt1 == 'I want to buy it!') {
                              visCheck = true;
                            } else {
                              visCheck = false;
                            }
                            txt1 = 'Payment Method?';
                          });
                        },
                        textColor: Colors.lightBlueAccent,
                        fontSize: kFontSize,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.02),
                      child: RoundedButton(
                        title: txt2,
                        color: Colors.white,
                        onPressed: () {
                          messageText = txt2;
                          _firestore
                              .collection('Messages')
                              .doc(widget.user1)
                              .collection('Users')
                              .doc(createChatRoomID(widget.user1, widget.user2))
                              .collection('Chats')
                              .add({
                            'text': messageText,
                            'description': {},
                            'sender': user?.email,
                            'type': 'text',
                            'time': FieldValue.serverTimestamp(),
                          });
                          _firestore
                              .collection('Messages')
                              .doc(toBeUsedID)
                              .collection('Users')
                              .doc(createChatRoomID(user?.uid, toBeUsedID))
                              .collection('Chats')
                              .add(
                            {
                              'text': messageText,
                              'description': {},
                              'sender': toBeContactedUser,
                              'type': 'text',
                              'time': FieldValue.serverTimestamp(),
                            },
                          );

                          _firestore
                              .collection("Messages")
                              .doc(user?.uid)
                              .collection("Users")
                              .doc(createChatRoomID(widget.user1, widget.user2))
                              .update({
                            'time': FieldValue.serverTimestamp(),
                          });

                          _firestore
                              .collection("Messages")
                              .doc(widget.user2)
                              .collection("Users")
                              .doc(createChatRoomID(widget.user1, widget.user2))
                              .update({
                            'time': FieldValue.serverTimestamp(),
                          });

                          setState(() {
                            if (txt1 == 'Can we meet?') {
                              visCheck = true;
                            } else {
                              visCheck = false;
                            }
                            txt2 = 'How much?';
                          });
                        },
                        textColor: Colors.lightBlueAccent,
                        fontSize: kFontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: kMessageTextFieldDecoration.copyWith(
                        suffixIcon: IconButton(
                      icon: const Icon(Icons.image_sharp),
                      onPressed: () {
                        getImage();
                      },
                    )),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      try {
                        DocumentSnapshot data = await _firestore
                            .collection("userProfile")
                            .doc(widget.user2)
                            .get();

                        sendPushNotifications(
                            data['token'], userName, messageText);
                      } catch (e) {
                        print(e);
                      }

                      messageTextController.clear();

                      _firestore
                          .collection('Messages')
                          .doc(widget.user1)
                          .collection('Users')
                          .doc(createChatRoomID(widget.user1, widget.user2))
                          .collection('Chats')
                          .add(
                        {
                          'text': messageText,
                          'description': {},
                          'sender': user?.email,
                          'type': 'text',
                          'time': FieldValue.serverTimestamp(),
                        },
                      );
                      _firestore
                          .collection('Messages')
                          .doc(widget.user2)
                          .collection('Users')
                          .doc(createChatRoomID(widget.user1, widget.user2))
                          .collection('Chats')
                          .add(
                        {
                          'text': messageText,
                          'description': {},
                          'sender': toBeContactedUser,
                          'type': 'text',
                          'time': FieldValue.serverTimestamp(),
                        },
                      );
                      _firestore
                          .collection("Messages")
                          .doc(user?.uid)
                          .collection("Users")
                          .doc(createChatRoomID(widget.user1, widget.user2))
                          .update({
                        'time': FieldValue.serverTimestamp(),
                      });

                      _firestore
                          .collection("Messages")
                          .doc(widget.user2)
                          .collection("Users")
                          .doc(createChatRoomID(widget.user1, widget.user2))
                          .update({
                        'time': FieldValue.serverTimestamp(),
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
}
