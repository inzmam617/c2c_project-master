import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Drafts extends StatefulWidget {
  const Drafts({Key? key}) : super(key: key);

  @override
  State<Drafts> createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream:  FirebaseFirestore.instance
              .collection('Drafts')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('Products')
              .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.5
                      )
                    ]

                  ),
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 100,
                              child: Image.network(snapshot.data?.docs[index]["images"][0],fit: BoxFit.cover,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data?.docs[index]["title"]  ,style: TextStyle(color: Colors.black54,fontSize: 15),),
                                  Text('\$${snapshot.data?.docs[index]["cost"]}',style: TextStyle(color: Colors.black54,fontSize: 15 )),
                                  TextButton(
                                      onPressed: () async {
                                        // snapshot.data?.docs.removeAt(index);
                                        final CollectionReference documentsCollection = FirebaseFirestore.instance.collection('Drafts').doc(FirebaseAuth.instance.currentUser?.uid).collection("Products");
                                        //
                                        // FirebaseFirestore.instance.collection("Drafts").doc(FirebaseAuth.instance.currentUser?.uid).collection("Products").doc("xN4I1E6WHYYLImvmjHfe").delete();
                                        final QuerySnapshot querySnapshot = await documentsCollection.get();
                                        final DocumentSnapshot documentSnapshot = querySnapshot.docs.elementAt(index);
                                        await documentSnapshot.reference.delete();



                                        // FirebaseFirestore.instance.collection('Drafts')
                                        //     .doc(FirebaseAuth.instance.currentUser?.uid)
                                        //     .collection('Products').doc().delete();

                                      },
                                      child: const Text("Detele from Drafts",style: TextStyle(color: Color(0xffFD8A00),fontSize: 15)))
                                ],
                              ),
                            ),
                          ],
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: (){
                              print("asd");

                            },
                              child: SvgPicture.asset("assets/Edit.svg")),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },);
          }

              return Center(child: Text("No Drafts"),);

          }
        ),
      ),
    );
  }
}
