import 'package:c2c_project1/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'index_screen.dart';
import 'inbox_screen.dart';
import 'account_screen.dart';
import 'post_screen.dart';
import 'selling_screen.dart';

int currentIndex = 0;
final _firestore = FirebaseFirestore.instance;

class HomesPage extends StatefulWidget {
  const HomesPage({Key? key}) : super(key: key);

  @override
  State<HomesPage> createState() => _HomesPageState();
}

class _HomesPageState extends State<HomesPage> with WidgetsBindingObserver {
  final screens = const [
    IndexPage(),
    InboxPage(),
    PostPage(),
    SellPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus('Online');
  }

  void setStatus(String status) async {
    await _firestore.collection('userProfile').doc(user?.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus('Online');
    } else {
      setStatus('Offline');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_camera),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sell),
              label: 'My Closet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
        ),
      );
}
