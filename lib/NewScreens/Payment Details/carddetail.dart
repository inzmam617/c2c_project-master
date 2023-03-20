import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'checkout2.dart';

class carddetail extends StatelessWidget {
  const carddetail({Key? key}) : super(key: key);

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
          "Card Details",
          style: TextStyle(fontSize: 18, color: Color(0xff020203)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: SvgPicture.asset(
                "assets/image/Group 1783.svg",
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(right: 250),
              child: Text(
                "Card Holder",
                style: TextStyle(fontSize: 12, color: Color(0xffA3A3A3)),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: TextFormField(
                style: const TextStyle(color: Color(0xffC0BDBD)),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 16),
                  prefixIcon: SvgPicture.asset(
                    "assets/Iconly-Bold-Profile.svg",
                    fit: BoxFit.scaleDown,
                  ),
                  hintText: "Person",
                  hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(right: 240),
              child: Text(
                "Card Number",
                style: TextStyle(fontSize: 12, color: Color(0xffA3A3A3)),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: TextFormField(
                style: const TextStyle(color: Color(0xffC0BDBD)),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 16),
                  prefixIcon: SvgPicture.asset(
                    "assets/multiple.svg",
                    fit: BoxFit.scaleDown,
                  ),
                  hintText: "888532112155",
                  hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Expiry Date",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffA3A3A3)),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.9,
                        child: TextFormField(
                          style: const TextStyle(color: Color(0xffC0BDBD)),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 16),
                            prefixIcon: SvgPicture.asset(
                              "assets/basket.svg",
                              fit: BoxFit.scaleDown,
                            ),
                            hintText: "01/2022",
                            hintStyle:
                                const TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "CCV",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffA3A3A3)),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.9,
                        child: TextFormField(
                          style: const TextStyle(color: Color(0xffC0BDBD)),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 16),
                            prefixIcon: SvgPicture.asset(
                              "assets/Lock.svg",
                              fit: BoxFit.scaleDown,
                            ),
                            hintText: "0 0 0",
                            hintStyle:
                                const TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 195,
              height: 35,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const checkout2();
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
