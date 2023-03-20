import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({Key? key, required this.imageURL}) : super(key: key);

  final String imageURL;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageURL),
      ),
    );
  }
}
