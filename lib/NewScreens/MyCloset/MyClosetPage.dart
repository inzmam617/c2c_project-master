import 'package:flutter/material.dart';
import '../../bottom_icons_icons.dart';
import '../Cart/CartPage.dart';
import '../HomePages/Home.dart';
import '../Post/PostPage.dart';
import '../ProfilePage/ProfilePage.dart';
import 'ArchivedPage.dart';
import 'Drafts.dart';
import 'ForSalePage.dart';

class MyClosetPage extends StatefulWidget  {
  const MyClosetPage({Key? key}) : super(key: key);

  @override
  State<MyClosetPage> createState() => _MyClosetPageState();
}

class _MyClosetPageState extends State<MyClosetPage>  with TickerProviderStateMixin {
  List pages = [
    const HomePage(),
    const CartPage(),
    const PostPage(),
    const MyClosetPage(),
    const ProfilePage(),
  ];
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this,initialIndex: 0);

  }
  int currentIndex = 0;
  List<Widget> page = [
    const ForSale(),
    const ArchivedPage(),
    const Drafts(),
  ];

  void _onItemTapped(int Index) {
    setState(() {
      currentIndex = Index;
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return pages[Index];
    }));
    print(Index);
  }
  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("My Closet",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold ),),
            leading: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_rounded,color: Colors.black,),
            ),
            backgroundColor:Colors.white,
            bottom:  TabBar(
              isScrollable: true,
              // labelPadding: EdgeInsets.zero,

              // unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyle(color: Colors.grey.shade50),

              labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                indicatorColor: Colors.black,
              indicatorWeight: 1.2,
              //   dividerColor: Colors.white,
                controller: tabController,
                tabs:  const [
                  Tab(

                    child: Text("For Sale",style: TextStyle(fontSize: 12),),

                  ),
                  Tab(
                    child: Text("Archived",style: TextStyle(fontSize: 12),),
                  ),
                  Tab(
                    child: Text("Drafts",style: TextStyle(fontSize: 12),),
                  )
                ]),
          ),
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
                  bottomLeft: Radius.circular(20)),
            ),
            margin: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(
                      Icons.home_filled,
                      //color: Colors.grey,
                    ),
                    //label: '',
                  ),
                  BottomNavigationBarItem(
                    label: "Cart",
                    icon: Icon(BottomIcons.buy
                        // color: Colors.grey,
                        ),
                    //label: '',
                  ),
                  BottomNavigationBarItem(
                    label: "Post",
                    icon: Icon(BottomIcons.camera
                        //  color: Colors.grey,
                        ),
                  ),
                  BottomNavigationBarItem(
                    label: "My Closet",

                    icon: Icon(BottomIcons.iconly_light_bag
                        //  color: Colors.grey,
                        ),
                    //label: '',
                  ),
                  BottomNavigationBarItem(
                    label: "Account",
                    icon: Icon(BottomIcons.profile
                        // color: Colors.grey,
                        ),
                  ),
                ],
                currentIndex: 3,
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
        body: TabBarView(
          controller: tabController,
          children: page,
        ),
      ),
    );
  }
}
