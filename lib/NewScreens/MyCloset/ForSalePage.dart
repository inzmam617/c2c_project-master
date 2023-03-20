import 'package:flutter/material.dart';

class ForSale extends StatefulWidget {
  const ForSale({Key? key}) : super(key: key);

  @override
  State<ForSale> createState() => _ForSaleState();
}

class _ForSaleState extends State<ForSale> {
  List dresstwo = [
    "one.jpg",
    "two.jpg",
    "three.jpg",
    "four.jpg",
    "five.jpg",
    "six.jpg",
    "seven.jpg",
    "eight.jpg",
    "dressSeven.png",
    "dressEight.png",
    "dressNine.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
        child: Center(
          child: GridView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio:
                  ((MediaQuery.of(context).size.width /2) /240),
                  crossAxisCount: 2),
              itemCount: dresstwo.length,
              itemBuilder: (BuildContext ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context)
                            .size
                            .width /
                            2.5,
                        height: 170,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/" + dresstwo[index],
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                            BorderRadius.circular(10)),
                        // child: Column(
                        //   crossAxisAlignment:
                        //   CrossAxisAlignment.end,
                        //   mainAxisAlignment:
                        //   MainAxisAlignment.end,
                        //   children: [
                        //     Transform.translate(
                        //       offset: const Offset(-10, 10),
                        //       child: InkWell(
                        //         onTap: () {
                        //           setState(() {
                        //             like = !like;
                        //           });
                        //         },
                        //         child: Container(
                        //             height: 30,
                        //             width: 30,
                        //             decoration: const BoxDecoration(
                        //                 boxShadow: [
                        //                   BoxShadow(
                        //                       color:
                        //                       Colors.grey,
                        //                       blurRadius: 5.0)
                        //                 ],
                        //                 color: Colors.white,
                        //                 borderRadius:
                        //                 BorderRadius.all(
                        //                     Radius.circular(
                        //                         100))),
                        //             child: like == true
                        //                 ? Center(
                        //                 child: SvgPicture
                        //                     .asset(
                        //                     'assets/Heart.svg'))
                        //                 : Center(
                        //                 child: SvgPicture
                        //                     .asset(
                        //                     'assets/EHeart.svg'))),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Cotton Shirt",
                        style: TextStyle(color: Colors.black),
                      ),
                      const Text(
                        '\$23',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
