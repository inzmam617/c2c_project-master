import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class checkout2 extends StatefulWidget {
  const checkout2({Key? key}) : super(key: key);

  @override
  State<checkout2> createState() => _checkout2State();
}

class _checkout2State extends State<checkout2> {
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
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: Colors.grey,
                offset: Offset(1.0, 2.0),
              )
            ]),
            height: 55,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Order",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "424923192 - N",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )
                    ],
                  ),
                  const Text(
                    "Placed on 11 Sep 2022",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 1, color: Colors.grey, offset: Offset(1.0, 2.0))
            ]),
            height: 170,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Shipping Address",
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "21, Alex Davidson Avenue, Opposite Omegatron, Vicent Smith Quarters, Victoria Island, Lagos, Nigeria",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Change",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                Checkbox(
                    value: ischecked,
                    activeColor: const Color(0xffFD8A00),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onChanged: (newbool) {
                      setState(() {
                        ischecked = newbool;
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
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Payment",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/logo.svg"),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Master Card",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff929292)),
                              ),
                              Text(
                                "****  ****  ****  4543",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              )
                            ],
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
                            });
                          })
                    ],
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Change",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffFD8A00)),
                      ))
                ],
              ),
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
                onPressed: () {},
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
