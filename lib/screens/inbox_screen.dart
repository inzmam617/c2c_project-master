import 'package:c2c_project1/components/inbox_card.dart';
import 'package:c2c_project1/components/notification_manager.dart';
import 'package:flutter/material.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                backgroundColor: Colors.blue,
                bottom: const TabBar(
                  tabs: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Messages",
                        style: TextStyle(
                          fontFamily: "Ubuntu",
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Text(
                      "Notifications",
                      style: TextStyle(
                        fontFamily: "Ubuntu",
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                title: const Text("Inbox")),
            body: const TabBarView(
              children: <Widget>[
                InboxChats(),
                Notifications(),
              ],
            ),
          ),
        ),
      );
}
