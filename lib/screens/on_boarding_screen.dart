import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'get_started_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageViewController = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            isLastPage = index == 2;
          });
        },
        controller: _pageViewController,
        children: [
          Container(
            width: 70,
            height: 70,
            color: const Color(0xFF5D8FFF),
            child: Image.asset('images/1.png'),
          ),
          Container(
            width: 50,
            height: 50,
            color: const Color(0xFF5D8FFF),
            child: Image.asset('images/2.png'),
          ),
          Container(
            width: 30,
            height: 30,
            color: const Color(0xFF5D8FFF),
            child: Image.asset('images/3.png'),
          ),
        ],
      ),
      bottomSheet: isLastPage
          ? Container(
              height: 80,
              color: const Color(0xFF5D8FFF),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GetStarted()),
                  );
                },
                child: const Center(
                  child: Text(
                    'Let\'s Go!',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            )
          : Container(
              height: 80,
              color: const Color(0xFF5D8FFF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _pageViewController.jumpToPage(2);
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      count: 3,
                      effect: const WormEffect(
                        activeDotColor: Colors.white70,
                        dotColor: Colors.white12,
                      ),
                      controller: _pageViewController,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _pageViewController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
