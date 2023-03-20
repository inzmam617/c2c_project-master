import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:c2c_project1/components/rounded_button.dart';
import 'package:c2c_project1/constants.dart';
import 'package:c2c_project1/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {});
      // print(controller.value);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Colors.green.withOpacity(controller.value),
      body: Container(
        height: 650,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: const Color(0xFF5D8FFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Transform.rotate(
                  angle: 50,
                  child: SizedBox(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontFamily: "Satisfy",
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText(
                            'X Closet',
                            speed: const Duration(milliseconds: 150),
                          ),
                        ],
                        totalRepeatCount: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: Text(
                "ALL YOUR",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontFamily: "Montserrat-Medium",
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                "OUTFIT",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    decoration: TextDecoration.underline,
                    fontFamily: "Montserrat-Medium",
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Ubuntu-Medium',
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'GET EVERYTHING YOU WANT!',
                          speed: const Duration(milliseconds: 150),
                        ),
                        TypewriterAnimatedText(
                          'BUY!',
                          speed: const Duration(milliseconds: 150),
                        ),
                        TypewriterAnimatedText(
                          'SELL!',
                          speed: const Duration(milliseconds: 150),
                        ),
                        TypewriterAnimatedText(
                          'EARN!',
                          speed: const Duration(milliseconds: 150),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            RoundedButton(
                title: 'Get Started',
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnBoardingScreen(),
                    ),
                  );
                },
                textColor: Colors.blueAccent,
                fontSize: kFontSize)
          ],
        ),
      ),
    );
  }
}
