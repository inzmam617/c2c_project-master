import 'package:c2c_project1/Services.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:c2c_project1/screens/saved_posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:c2c_project1/screens/view_profile.dart';
import 'package:c2c_project1/screens/edit_profile.dart';
import 'package:c2c_project1/screens/query_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:c2c_project1/screens/help.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'storageManager.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final Storage storage = Storage();
  bool showSpinner = false;

  Future<void> signOut() async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: 'uid');

    await GoogleLogin().signOutFromGoogle();
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          children: <Widget>[
            const ViewAccount(),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditSProfile()),
                  );
                },
                child: const Text('Edit Profile')),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewsProfile()),
                );
              },
              child: const ListTile(
                leading: Icon(Icons.account_box),
                title: Text('View Profile'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SavedPosts()),
                );
              },
              child: const ListTile(
                leading: Icon(Icons.favorite),
                title: Text('My Wishlist'),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const ListTile(
                leading: Icon(Icons.payments),
                title: Text('Manage Payments'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QueryChatScreen()),
                );
              },
              child: const ListTile(
                leading: Icon(Icons.question_answer),
                title: Text('Got Questions? Ask Us Here!'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpSupport()),
                );
              },
              child: const ListTile(
                leading: Icon(Icons.help_center),
                title: Text('Help'),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Confirm Logout"),
                      content: const Text("Do you really want to logout?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            try {
                              signOut().then((value) async {
                                await Future.delayed(
                                    const Duration(seconds: 2));
                              });
                              SystemChannels.platform
                                  .invokeMethod<void>('SystemNavigator.pop');
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Something Went Wrong! Logging out failed.'),
                                ),
                              );
                            }
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("Yes"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("No"),
                        )
                      ],
                    ),
                  );
                });
              },
              child: const ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
              ),
            ),
          ],
        ),
      );
}

class ViewAccount extends StatefulWidget {
  const ViewAccount({Key? key}) : super(key: key);

  @override
  State<ViewAccount> createState() => _ViewAccountState();
}

class _ViewAccountState extends State<ViewAccount> {
  final _firestore = FirebaseFirestore.instance;
  String name = '';
  String picture = '';

  getProfile() async {
    var profileData =
        await _firestore.collection("userProfile").doc(user?.uid).get();

    var userName = profileData.data()!['username'];
    setState(() {
      name = userName;
      editUsername = userName;
    });

    var profile = profileData.data()!['profilePicture'];
    setState(() {
      picture = profile;
      editProfile = profile;
    });
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
          child: TextButton(
            onPressed: () {},
            child: (picture != '')
                ? ProfilePicture(
                    name: name,
                    radius: 100.0,
                    fontsize: 21,
                    img: picture,
                  )
                : ProfilePicture(
                    name: name,
                    radius: 100.0,
                    fontsize: 21,
                  ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
