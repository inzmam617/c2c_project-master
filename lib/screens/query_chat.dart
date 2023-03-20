import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:c2c_project1/screens/profile.dart';
import '../components/message_components.dart';
import 'package:c2c_project1/constants.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class QueryChatScreen extends StatefulWidget {
  const QueryChatScreen({Key? key}) : super(key: key);

  @override
  State<QueryChatScreen> createState() => _QueryChatScreenState();
}

class _QueryChatScreenState extends State<QueryChatScreen> {
  final messageTextController = TextEditingController();
  late String messageText;
  bool visCheck = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Ask Us!'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/chatBg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              MessagesStream(
                messageStream: _firestore
                    .collection('Messages')
                    .doc(user?.uid)
                    .collection('Query')
                    .orderBy('time', descending: false)
                    .snapshots(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore
                            .collection('Messages')
                            .doc(user?.uid)
                            .collection('Query')
                            .add(
                          {
                            'text': messageText,
                            'type': 'text',
                            'description': {},
                            'sender': user?.email,
                            'time': FieldValue.serverTimestamp(),
                          },
                        );
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
        ),
      );
}
