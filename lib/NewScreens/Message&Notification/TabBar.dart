import 'package:flutter/material.dart';

import '../../bottom_icons_icons.dart';
import '../../chaticons_icons.dart';
// import '../../screens/post_screen.dart';
import '../../components/inbox_card.dart';
import '../HomePages/Home.dart';
import '../MyCloset/MyClosetPage.dart';
import '../Post/PostPage.dart';
import '../ProfilePage/ProfilePage.dart';

import 'MessagePage.dart';
import 'NotificationsPage.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin {

  List<Widget> newpages = [
    // InboxChats(),
    MessagePage(),
    NotificationPage(),
  ];
     List pages = [
    const HomePage(),
    const TabBarPage(),
    const PostPage(),
    const MyClosetPage(),
    const ProfilePage(),


  ];
     int currentIndex = 0;
     void _onItemTapped(int Index){
    setState(() {

      currentIndex = Index;

    });
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return pages[Index];
    }));
    print(Index);

  }
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this,initialIndex: 0);
  }

   late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3.0,
              ),
            ],
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)
            ),
          ),
          margin: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: "Home",
                  icon: Container(
                    //padding: const EdgeInsets.all(7),
                      child: const Icon(
                        Icons.home_filled,
                        //color: Colors.grey,
                      )),
                  //label: '',
                ),
                BottomNavigationBarItem(
                  label: "Chat",
                  icon: Container(
                    //padding: const EdgeInsets.all(7),
                      child: const Icon(Chaticons.chat
                        //  color: Colors.grey,
                      )),
                  //label: '',
                ),
                BottomNavigationBarItem(
                  label: "Post",
                  icon: Container(
                    //padding: const EdgeInsets.all(7),
                      child: const Icon(
                          BottomIcons.camera
                        //  color: Colors.grey,
                      )),
                ),
                BottomNavigationBarItem(
                  label: "My Closet" ,

                  icon: Container(
                    //padding: const EdgeInsets.all(7),
                      child: const Icon(
                          BottomIcons.iconly_light_bag
                        //  color: Colors.grey,
                      )),
                  //label: '',
                ),
                BottomNavigationBarItem(
                  label: "Account",
                  icon: Container(
                    //padding: const EdgeInsets.all(7),
                      child: const Icon(
                          BottomIcons.profile
                        // color: Colors.grey,
                      )),
                  //label: '',
                ),




              ],
              currentIndex: 1,
              selectedIconTheme:
              const IconThemeData(color: Color(0xffFD8A00), size: 25),
              unselectedIconTheme:
              const IconThemeData(color: Colors.grey, size: 20),
              selectedItemColor: const Color(0xffFD8A00),
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: _onItemTapped,
              selectedFontSize: 9,
              unselectedFontSize: 8,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ),
      ),
        appBar: AppBar(
          toolbarHeight: 40,
          automaticallyImplyLeading: false,
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
          children: newpages,
        ),
      ),
    );
  }
}
