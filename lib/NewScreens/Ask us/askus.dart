import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class askus extends StatelessWidget {
  const askus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          "Ask Us!",
          style: TextStyle(fontSize: 18, color: Color(0xff020203)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 150),
          SvgPicture.asset("assets/Orange chat.svg"),
          const SizedBox(height: 10),
          const Text(
            "We Will be Happy to ",
            style: TextStyle(fontSize: 18),
          ),
          const Text("Help You!", style: TextStyle(fontSize: 18)),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            color: Colors.grey,
                            offset: Offset(1.0, 2.0))
                      ]),
                  height: 50,
                  width: 400,
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 15),
                        hintText: ("Type your message here.."),
                        prefixIcon: SvgPicture.asset(
                          "assets/Search.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
