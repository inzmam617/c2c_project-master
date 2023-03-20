import 'package:flutter/material.dart';

class help extends StatelessWidget {
  const help({Key? key}) : super(key: key);

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
          "Help",
          style: TextStyle(fontSize: 18, color: Color(0xff020203)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 5,
              shadowColor: Colors.grey,
              child: ListTile(
                title: const Text(
                  "Track my order",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                subtitle: const Text(
                  "Contact Seller & Order Status",
                  style: TextStyle(fontSize: 10, color: Color(0xff97AABD)),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onTap: () {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (BuildContext context) {
                  //   return checkout();
                  // }));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 5,
              shadowColor: Colors.grey,
              child: ListTile(
                title: const Text(
                  "I want to manage my order",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                subtitle: const Text("Contact Seller & Order Status",
                    style: TextStyle(fontSize: 10, color: Color(0xff97AABD))),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onTap: () {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (BuildContext context) {
                  //   return mywishlist();
                  // }));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 5,
              shadowColor: Colors.grey,
              child: ListTile(
                title: const Text(
                  "I want to help with returns & refunds",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                subtitle: const Text("Manage & Track refund",
                    style: TextStyle(fontSize: 10, color: Color(0xff97AABD))),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onTap: () {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (BuildContext context) {
                  //   return askus();
                  // }));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
