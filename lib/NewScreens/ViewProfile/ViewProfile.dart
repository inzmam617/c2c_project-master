import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  var savedPostsList ;
  getData() {
    return FirebaseFirestore.instance.collection("userProfile").doc(FirebaseAuth.instance.currentUser?.uid).snapshots();
  }
  void iniState(){
    getData();
    super.initState();
  }
  double avgRating = 0;
  @override
  Widget build(BuildContext context) {
    print(savedPostsList);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          "View Profile",
          style: TextStyle(fontSize: 18, color: Color(0xff020203)),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: getData(),
        builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData) {
            var rating = snapshot.data?.get("rating");
            avgRating = (rating['1']['0'] * 1 +
                rating['2']['0'] * 2 +
                rating['3']['0'] * 3 +
                rating['4']['0'] * 4 +
                rating['5']['0'] * 5) /
                (rating['1']['0'] +
                    rating['2']['0'] +
                    rating['3']['0'] +
                    rating['4']['0'] +
                    rating['5']['0']);
            return Column(
              children: [
                const SizedBox(height: 50,),
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                  ),
                ),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("First Name : ",
                      style: TextStyle(color: Colors.black, fontSize: 17),),
                    Text(snapshot.data["username"] ,
                      style: const TextStyle(color: Colors.black, fontSize: 17),)
                  ],
                ),
                const SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Last Name : ",
                      style: TextStyle(color: Colors.black, fontSize: 17),),
                    Text(snapshot.data["lastname"],
                      style: const TextStyle(color: Colors.black, fontSize: 17),)
                  ],
                ),
                const SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Email : ",
                      style: TextStyle(color: Colors.black, fontSize: 17),),
                    Text(snapshot.data["email"] ,
                      style: const TextStyle(color: Colors.black, fontSize: 17),)
                  ],
                ),
                const SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Address: ",
                      style: TextStyle(color: Colors.black, fontSize: 17),),
                    Text(snapshot.data["address"],
                      style: const TextStyle(color: Colors.black, fontSize: 17),)
                  ],
                ),
                const SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Phone Number : ",
                      style: TextStyle(color: Colors.black, fontSize: 17),),
                    Text(snapshot.data["Phone"].toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 17),)
                  ],
                ),
                    const SizedBox(height: 20,),
                    RatingBar(
                    itemSize: MediaQuery.of(context).size.width * 0.08,
                    ignoreGestures: true,
                    initialRating: avgRating,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    ratingWidget: RatingWidget(
                    full: const Icon(Icons.star,
                    color: Colors.yellow),
                    half: const Icon(
                    Icons.star_half,
                    color: Colors.yellow,
                    ),
                    empty: const Icon(
                    Icons.star_outline,
                    color: Colors.yellow,
                    )),
                    onRatingUpdate: (double value) {},
                    )

              ],
            );
          }
          else {
            return const Center(child: Text("No Data Yet"),);
          }
        }
      ),
    );
  }
}
