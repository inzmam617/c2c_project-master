import 'package:flutter/material.dart';

import 'SliderPageOne.dart';
import 'SliderPagesThree.dart';
import 'SliderPagesTwo.dart';

class SliderPages extends StatefulWidget {
  const SliderPages({Key? key}) : super(key: key);

  @override
  State<SliderPages> createState() => _SliderPagesState();
}

class _SliderPagesState extends State<SliderPages> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          SliderPageOne(),
          SliderPageTwo(),
          SliderPagesThree()
        ],
      )
    );
  }
}
