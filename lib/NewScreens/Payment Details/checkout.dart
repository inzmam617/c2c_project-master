import 'package:flutter/material.dart';

import 'checkout1.dart';

class checkout extends StatelessWidget {
  const checkout({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
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
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: TextFormField(cursorColor: Colors.black,
                cursorWidth: 0.5,
                style: const TextStyle(color: Color(0xffAEAEAE),fontSize: 12),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 18),
                  hintText: "Name",
                  hintStyle: TextStyle(color: Color(0xffAEAEAE),fontSize: 12),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: TextFormField(cursorColor: Colors.black,
                cursorWidth: 0.5,
                style: const TextStyle(color: Color(0xffAEAEAE),fontSize: 12),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 18),
                  hintText: "Mobile Number",
                  hintStyle: TextStyle(color: Color(0xffAEAEAE),fontSize: 12),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: TextFormField(cursorColor: Colors.black,
                cursorWidth: 0.5,
                style: const TextStyle(color: Color(0xffAEAEAE),fontSize: 12),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 18),
                  hintText: "City",
                  hintStyle: TextStyle(color: Color(0xffAEAEAE),fontSize: 12),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: TextFormField(cursorColor: Colors.black,
                cursorWidth: 0.5,
                style: const TextStyle(color: Color(0xffAEAEAE),fontSize: 12),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 18),
                  hintText: "Area",
                  hintStyle: TextStyle(color: Color(0xffAEAEAE),fontSize: 12),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: TextFormField(
                cursorColor: Colors.black,
                cursorWidth: 0.5,
                style: const TextStyle(color: Color(0xffAEAEAE),fontSize: 12),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 18),
                  hintText: "Address",
                  hintStyle: TextStyle(color: Color(0xffAEAEAE),fontSize: 12),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 195,
              height: 35,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const checkout1();
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
      ),
    );
  }
}
