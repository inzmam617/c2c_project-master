import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../HomePages/Home.dart';
import '../SignIn/SignIn.dart';

class SliderPageTwo extends StatelessWidget {
  const SliderPageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: SvgPicture.asset(
                    "assets/stars.svg",
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only( right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: (){

                          },
                          child: SvgPicture.asset("assets/backbutton.svg",height: MediaQuery.of(context).size.height / 6 ,)),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) {
                                    return const HomePage();
                                  }));
                            },
                            child: const Text(
                              "Skip",
                              style: TextStyle(color: Colors.black),
                            )),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 140),
                    child: SvgPicture.asset(
                      "assets/pageTwo.svg",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Stack(children: [
                Center(
                  child: SvgPicture.asset("assets/circles_round.svg"),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                    child: Column(
                      children:  [
                        const Text(
                          "Lorem ipsum dolor \n sit amet consectur",
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Lorem ipsum dolor sit amet, \n consectetur adipiscing elit.",
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SvgPicture.asset("assets/scrolltwo.svg")
                      ],
                    ),
                  ),
                ),
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [


                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const SignIn();
                                    }));
                              },
                              child: SvgPicture.asset("assets/redbutton.svg",
                                  height: MediaQuery.of(context).size.height / 6))
                        ],
                      ),
                    )
                  ],
                )
              ]),
            )
          ],
        ));
  }
}
