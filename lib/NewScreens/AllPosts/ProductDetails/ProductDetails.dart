
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../screens/chat_screen.dart';
import '../../Message&Notification/TabBar.dart';

class ProductDetails extends StatefulWidget {
  final details;
  const ProductDetails({Key? key, this.details}) : super(key: key);
  @override
  State<ProductDetails> createState() => _ProductDetailsState(detils: details);
}

class _ProductDetailsState extends State<ProductDetails> {



 final detils;
  _ProductDetailsState({this.detils});
  // String name = detils[""];
  // final store =  FirebaseFirestore.instance.collection("userprofile").doc(detils[""]);
  final _firestore = FirebaseFirestore.instance;
  getStream() {
    return _firestore
        .collection('userProfile').doc(detils["uID"])
        // .where('archive', isEqualTo: 'no')
        // .orderBy('time', descending: true)
        .snapshots();
  }
  int number = 0;


  bool offwhite = false;
  bool pink = false;
  bool purple = false;
  bool blue = false;
  bool small = false;
  bool medium = false;
  bool large = false;
  bool xlarge = false;
  PageController dresss = PageController();
  bool like = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3.0,
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 90),
          child: SizedBox(
              height: 40,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))
                      )),
                      backgroundColor: MaterialStateProperty.all(const Color(0xffFD8A00))
                  ),
                  onPressed: (){
                    print(detils["address"]);

                  }, child: const Text("Buy Now"))),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.2,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: dresss,
                    itemCount: (detils["images"]).length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Image.network(
                          detils["images"][index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SmoothPageIndicator(
                        controller: dresss,
                        count: (detils["images"]).length,
                        axisDirection: Axis.horizontal,
                        effect: SlideEffect(
                            spacing: 8.0,
                            radius: 0.5,
                            dotWidth: 30.0,
                            dotHeight: 0.5,
                            paintStyle: PaintingStyle.stroke,
                            strokeWidth: 1.5,
                            dotColor: Colors.white.withOpacity(0.7),
                            activeDotColor: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            )),
                        InkWell(
                          onTap: () {
                            setState(() {
                              like = !like;
                            });
                          },
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey, blurRadius: 5.0)
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              child: like == true
                                  ? Center(
                                      child:
                                          SvgPicture.asset('assets/Heart.svg'))
                                  : Center(
                                      child: SvgPicture.asset(
                                          'assets/EHeart.svg'))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          (detils["title"]),
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/Location.svg"),
                          const SizedBox(
                            width: 5,
                          ),
                          Text((detils["address"]),
                              style: const TextStyle(color: Colors.grey))
                        ],
                      )
                    ],
                  ),
                  Text(
                    "\$${detils["cost"]}",
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Color",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                offwhite = !offwhite;
                                pink = false;
                                blue = false;
                                purple = false;
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border: offwhite
                                      ? Border.all(
                                          color: const Color(0xffB8D9FA),
                                          width: 2.5)
                                      : const Border(
                                          bottom: BorderSide.none,
                                          top: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide.none),
                                  color: const Color(0xffD8F0D6),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100))),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                pink = !pink;
                                offwhite = false;
                                blue = false;
                                purple = false;
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border: pink
                                      ? Border.all(
                                          color: const Color(0xffB8D9FA),
                                          width: 2.5)
                                      : const Border(
                                          bottom: BorderSide.none,
                                          top: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide.none),
                                  color: const Color(0xffFFE9D9),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(100))),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                purple = !purple;
                                pink = false;
                                blue = false;
                                offwhite = false;
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border: purple
                                      ? Border.all(
                                          color: const Color(0xffB8D9FA),
                                          width: 2.5)
                                      : const Border(
                                          bottom: BorderSide.none,
                                          top: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide.none),
                                  color: const Color(0xff9598FE),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(100))),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                blue = !blue;
                                pink = false;
                                offwhite = false;
                                purple = false;
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border: blue
                                      ? Border.all(
                                          color: const Color(0xffB8D9FA),
                                          width: 2.5)
                                      : const Border(
                                          bottom: BorderSide.none,
                                          top: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide.none),
                                  color: const Color(0xff7FBCFE),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(100))),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Size",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                small = !small;
                                medium = false;
                                large = false;
                                xlarge = false;
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border: small
                                      ? Border.all(
                                          color: const Color(0xffB8D9FA),
                                          width: 2.5)
                                      : const Border(
                                          bottom: BorderSide.none,
                                          top: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide.none),
                                  color: const Color(0xff97AABD),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(100))),
                              child: const Center(
                                child: Text(
                                  "S",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                medium = !medium;
                                small = false;
                                large = false;
                                xlarge = false;
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border: medium
                                      ? Border.all(
                                          color: const Color(0xffB8D9FA),
                                          width: 2.5)
                                      : const Border(
                                          bottom: BorderSide.none,
                                          top: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide.none),
                                  color: const Color(0xff97AABD),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(100))),
                              child: const Center(
                                child: Text(
                                  "M",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                large = !large;
                                small = false;
                                medium = false;
                                xlarge = false;
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border: large
                                      ? Border.all(
                                          color: const Color(0xffB8D9FA),
                                          width: 2.5)
                                      : const Border(
                                          bottom: BorderSide.none,
                                          top: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide.none),
                                  color: const Color(0xff97AABD),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(100))),
                              child: const Center(
                                child: Text(
                                  "L",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                xlarge = !xlarge;
                                small = false;
                                large = false;
                                medium = false;
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border: xlarge
                                      ? Border.all(
                                          color: const Color(0xffB8D9FA),
                                          width: 2.5)
                                      : const Border(
                                          bottom: BorderSide.none,
                                          top: BorderSide.none,
                                          left: BorderSide.none,
                                          right: BorderSide.none),
                                  color: const Color(0xff97AABD),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(100))),
                              child: const Center(
                                child: Text(
                                  "XL",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                    height: 30,
                    width: 100,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 3),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                          width: 40,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  number++;
                                });
                              },
                              icon: SvgPicture.asset(
                                "assets/add.svg",
                              )),
                        ),
                        Text(number.toString()),
                        SizedBox(
                          height: 30,
                          width: 40,
                          child: IconButton(
                              onPressed: () {
                                if (number == 0) {
                                  return;
                                } else {
                                  setState(() {
                                    number--;
                                  });
                                }
                              },
                              icon: SvgPicture.asset("assets/minus.svg")),
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:  [
                    const Text(
                      "Details",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      (detils["description"]),
                      style: const TextStyle(color: Colors.black54, fontSize: 12),
                    )
                  ],

                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Selling Rating: ",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  RatingBar.builder(
                    itemSize: 18,
                    unratedColor: Colors.grey,
                    initialRating: (detils["views"]) + .0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) =>
                        SvgPicture.asset("assets/Star.svg"),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: getStream(),

              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Product posted BY:"),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey, blurRadius: 3.5)
                                      ],
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/profile.png")
                                      )),
                                ),
                                const SizedBox(width: 20,),
                                Text(
                                  snapshot.data["username"],
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(
                                width: 120,
                                height: 35,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))
                                            )),
                                        backgroundColor: MaterialStateProperty
                                            .all(const Color(0xffFD8A00))
                                    ),
                                    onPressed: () {
                                      if(snapshot.data["uid"] == FirebaseAuth.instance.currentUser?.uid)
                                        {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('You Cannot Messege your Self'),
                                            ),
                                          );
                                        }
                                      else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return  ChatScreen(user1: FirebaseAuth.instance.currentUser?.uid, user2: snapshot.data["uid"],);
                                              }));
                                      }
                                    }, child: const Text("Message")))

                          ],
                        )
                      ],
                    ),
                  );
                }
                else{
                  return const Center(child: Text("no Data"),);
                }
              },
              // child:
            )
          ],
        ),
      ),
    );
  }
}
