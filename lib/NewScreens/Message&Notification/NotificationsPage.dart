import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Messages").doc(FirebaseAuth.instance.currentUser?.uid).collection("Notifications").snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                if(snapshot.data?.docs.length == 0 ){
                  return   Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 200,),
                      const Center(child: Text("No Notifications"),),
                    ],
                  );
                }
                else {
                  return Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: (){
                            print(snapshot.data?.docs.length);
                          },
                          child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 110,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(color: Colors.grey, blurRadius: 3.5),

                                  ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.topRight,
                                      child: Text("9:41",
                                        style: TextStyle(color: Colors.black),),
                                    ),
                                    Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(

                                            height: 75,
                                            width: 60,
                                            decoration: const BoxDecoration(
                                                color: Color(0xffFD8A00),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                  "assets/Notification.svg"),
                                            ),
                                          ),

                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: const [
                                              Text("Notification 1", style: TextStyle(
                                                  color: Colors.black),),
                                              Text(
                                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                                style: TextStyle(color: Colors.black,
                                                    fontSize: 10),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),

                                  ],
                                ),
                              )
                          ),
                        ),
                      );
                    },),
                );
                }
              }
              else{
                return const Center(child: Text("No Notifications"),);
              }
            }
        )
      ],
    );
  }
}


// Widget NotificationPage(){
//   return Column(
//     children: [
//       StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection("Messages").doc(FirebaseAuth.instance.currentUser?.uid).collection("Notifications").snapshots(),
//         builder: (context, snapshot) {
//           if(snapshot.hasData) {
//             return Expanded(
//               child: ListView.builder(
//                 itemCount: snapshot.data?.docs.length,
//                 physics: const ScrollPhysics(),
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: InkWell(
//                       onTap: (){
//                         print(snapshot.data);
//                       },
//                       child: Container(
//                           width: MediaQuery
//                               .of(context)
//                               .size
//                               .width,
//                           height: 110,
//                           decoration: const BoxDecoration(
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(color: Colors.grey, blurRadius: 3.5),
//
//                               ]
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
//                                 const Align(
//                                   alignment: Alignment.topRight,
//                                   child: Text("9:41",
//                                     style: TextStyle(color: Colors.black),),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Container(
//
//                                         height: 75,
//                                         width: 60,
//                                         decoration: const BoxDecoration(
//                                             color: Color(0xffFD8A00),
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(10))
//                                         ),
//                                         child: Center(
//                                           child: SvgPicture.asset(
//                                               "assets/Notification.svg"),
//                                         ),
//                                       ),
//
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8.0),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment
//                                             .start,
//                                         children: const [
//                                           Text("Notification 1", style: TextStyle(
//                                               color: Colors.black),),
//                                           Text(
//                                             "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
//                                             style: TextStyle(color: Colors.black,
//                                                 fontSize: 10),),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//
//                               ],
//                             ),
//                           )
//                       ),
//                     ),
//                   );
//                 },),
//             );
//           }
//           else{
//             return const Center(child: Text("No Notifications"),);
//           }
//         }
//       )
//     ],
//   );
// }