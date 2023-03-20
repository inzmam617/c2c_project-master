import 'package:flutter/material.dart';

import 'MessagePage.dart';
import 'NotificationsPage.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this,initialIndex: 0);

  }
  List<Widget> pages = [

    MessagePage(),
    NotificationPage(),
  ];
   late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: const Color(0xffFD8A00),
          bottom:  TabBar(
            indicatorColor: Colors.white,
            dividerColor: Colors.white,
            controller: tabController,
              tabs: const [
            Tab(
              text: "Messages",
            ),
            Tab(
              text: "Notification",
            )
          ]),
        ),
        body: TabBarView(
          controller: tabController,
          children: pages,
        ),
        // body: TabBarView(
        //   controller: tabController,
        //   children: const <Widget>
        //   [
        //     Center(child: MessagePage()),
        //     Center(child: NotificationsPage()),
        //   ],
        // ),


      ),
    );
  }
}
