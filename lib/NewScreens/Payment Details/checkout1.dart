import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'carddetail.dart';

class checkout1 extends StatefulWidget {
  const checkout1({Key? key}) : super(key: key);

  @override
  State<checkout1> createState() => _checkout1State();
}

class _checkout1State extends State<checkout1> {
  bool? ischecked = false;
  bool? ischecked1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          "Checkout",
          style: TextStyle(fontSize: 18, color: Color(0xff020203)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffFD8A00)),
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Color(0xffFD8A00),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                          ),
                        )),
                  ],
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width / 3.5,
                  color: const Color(0xffFD8A00),
                ),
                Column(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffFD8A00)),
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xffFD8A00),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width / 3.5,
                  color: Colors.grey,
                ),
                Column(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
          Container(
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 1, color: Colors.grey, offset: Offset(1.0, 2.0))
            ]),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SvgPicture.asset("assets/Group 195.svg"),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Cash on Delivery",
                      style: TextStyle(fontSize: 12, color: Color(0xff020203)),
                    ),
                  ],
                ),
                Checkbox(
                    value: ischecked,
                    activeColor: const Color(0xffFD8A00),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onChanged: (newbool) {
                      setState(() {
                        ischecked = newbool;
                        ischecked1 = false;
                      });
                    })
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 1, color: Colors.grey, offset: Offset(1.0, 2.0))
            ]),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SvgPicture.asset(
                          "assets/Icons-Multimedia-credit-card.svg"),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Credit/Debit Card",
                      style: TextStyle(fontSize: 12, color: Color(0xff020203)),
                    ),
                  ],
                ),
                Checkbox(
                    value: ischecked1,
                    activeColor: const Color(0xffFD8A00),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onChanged: (newbool) {
                      setState(() {
                        ischecked1 = newbool;
                        ischecked = false;
                      });
                    })
              ],
            ),
          ),
          const SizedBox(height: 40),
          Container(
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 1, color: Colors.grey, offset: Offset(1.0, 2.0))
            ]),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 16, color: Color(0xff020203)),
                  ),
                  Text(
                    "\$3950",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: 195,
            height: 35,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const carddetail();
                  }));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFD8A00),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32))),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
