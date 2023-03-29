import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import '../../screens/chat_screen.dart';

final _firestore = FirebaseFirestore.instance;
String toBeUsedID = '';
String toBeContactedUser = '';
String searchUser = '';
class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  @override
  void initState() {
    getUserBooks();
    setState(() {
    });
  }


  void getUserBooks() async {
    print(9);
    // await FirebaseFirestore.instance.collection("Messages").get().then((querySnapshot) async {
    //   querySnapshot.docs.forEach((result) async{
    //     if(result.get(userIds:"")){
    //
    //     }
    //     print("h:$result");
    //   });
    // });
  }


  List allUserList = [];
  checkIfProfilePicExists(uName, pPic) {
    if (pPic == '') {
      return ProfilePicture(
        name: uName,
        radius: 30.0,
        fontsize: 15.0,
      );
    } else {
      return ProfilePicture(
        name: uName,
        radius: 30.0,
        fontsize: 15.0,
        img: pPic,
      );
    }
  }
  Future<List> getallUsers()async{


    await FirebaseFirestore.instance.collection('Messages') .doc(FirebaseAuth.instance.currentUser?.uid ?? "").collection('Users')
        .get()
        .then((qSnap) {
      if (qSnap.docs.length > 0) {
        allUserList.clear();
        qSnap.docs.forEach((element) {
          allUserList.add(element);
          //* in future we can also remove friend whom already request sent
          // allUserList.add(UserModel.fromDocumentSnapshot(element));
        });
      }
    });
    return allUserList ;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       StreamBuilder<QuerySnapshot>(
         stream: FirebaseFirestore.instance.collection("Messages").where('userIds', arrayContains: '${FirebaseAuth.instance.currentUser?.uid}').snapshots(),
         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
           if(snapshot.hasData){
             final snaps = snapshot.data?.docs;
             List<Widget> list = [] ;
             for(var i in snaps!){
               list.add(TextButton(
                 onPressed: () {
                   toBeUsedID = i['uID'];
                   toBeContactedUser = i['userName'];

                   _firestore
                       .collection('userProfile')
                       .doc(FirebaseAuth.instance.currentUser?.uid)
                       .update({'chattingWith': toBeUsedID});

                   Navigator.of(context, rootNavigator: true).push(
                     // ensures fullscreen
                     CupertinoPageRoute(
                       builder: (BuildContext context) {
                         return ChatScreen(
                           user1: FirebaseAuth.instance.currentUser?.uid,
                           user2: toBeUsedID,
                         );
                       },
                     ),
                   );
                 },
                 child: ListTile(
                     title: Text(
                       i['userName'],
                     ),
                     contentPadding:
                     const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                     leading: checkIfProfilePicExists(
                         i['userName'], i['userProfile'])),
               ),);
             }
             return ListView(
               shrinkWrap: true,
               children: list,
             );
           }
           else{
             return CircularProgressIndicator();
           }

       },)

      ],
    );
  }
}

