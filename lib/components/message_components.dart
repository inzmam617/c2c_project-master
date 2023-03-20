import 'package:c2c_project1/components/show_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/profile.dart';

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key, required this.messageStream})
      : super(key: key);

  final Stream<QuerySnapshot> messageStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messageStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data?.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages!) {
          final messageText = message['text'];
          final messageSender = message['sender'];
          final messageType = message['type'];
          final messageDescription = message['description'];
          final currentTime = Timestamp.fromMicrosecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch);
          final messageTime = message['time'] == null
              ? currentTime
              : message['time'] as Timestamp;
          final currentUser = user?.email;

          final messageBubble = MessageBubble(
            text: messageText,
            sender: messageSender,
            isMe: currentUser == messageSender,
            time: messageTime,
            type: messageType,
            imgDescription: messageDescription,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02,
                vertical: MediaQuery.of(context).size.width * 0.02),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.text,
    required this.sender,
    required this.isMe,
    required this.time,
    required this.type,
    required this.imgDescription,
  }) : super(key: key);

  final String text;
  final String sender;
  final bool isMe;
  final String type;
  final Timestamp time;
  final Map imgDescription;

  @override
  Widget build(BuildContext context) {
    if (type == 'text') {
      return Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
              elevation: 5.0,
              color: isMe ? Colors.lightBlueAccent : Colors.white60,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.03,
                    horizontal: MediaQuery.of(context).size.width * 0.03),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.036,
                            color: isMe ? Colors.white : Colors.black54),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(
                          '${DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000).hour}:${DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000).minute}',
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black54,
                            fontSize: MediaQuery.of(context).size.width * 0.025,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (type == 'imgTxt') {
      return Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true)
                .push(// ensures fullscreen
                    CupertinoPageRoute(builder: (BuildContext context) {
              return ShowImage(imageURL: text);
            }));
          },
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                borderRadius: isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                elevation: 5.0,
                color: isMe ? Colors.lightBlueAccent : Colors.white60,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150.0,
                            height: 33.0,
                            child: Text(
                              'Title: ${imgDescription['title']}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.036,
                                  color: isMe ? Colors.white : Colors.black54),
                            ),
                          ),
                          SizedBox(
                            width: 150.0,
                            height: 18.0,
                            child: Text(
                              'Category: ${imgDescription['category']}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.036,
                                  color: isMe ? Colors.white : Colors.black54),
                            ),
                          ),
                          SizedBox(
                            width: 130.0,
                            height: 15.0,
                            child: Text(
                              'Description: ${imgDescription['productDescription']}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.036,
                                  color: isMe ? Colors.white : Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: isMe
                            ? const BorderRadius.only(
                                //topLeft: Radius.circular(30.0),
                                //bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              )
                            : const BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                // bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(text),
                        ),
                      ),
                      width: 80.0,
                      height: 120.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, bottom: 10.0),
                            child: Text(
                              '${DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000).hour}:${DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000).minute}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.025,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (type == 'image') {
      return Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true)
                .push(// ensures fullscreen
                    CupertinoPageRoute(builder: (BuildContext context) {
              return ShowImage(imageURL: text);
            }));
          },
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                borderRadius: isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                elevation: 5.0,
                color: isMe ? Colors.lightBlueAccent : Colors.white60,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: isMe
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              )
                            : const BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(text),
                        ),
                      ),
                      width: 200.0,
                      height: 300.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, bottom: 10.0),
                            child: Text(
                              '${DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000).hour}:${DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000).minute}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.025,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container();
  }
}
