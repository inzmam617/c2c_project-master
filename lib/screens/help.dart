import 'package:flutter/material.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Support'),
      ),
      body: ListView(
        children: [
          TextButton(
              onPressed: () {},
              child: ListTile(
                title: const Text('Track My Order'),
                subtitle: const Text(
                  'Contact Seller & Order Status',
                  style: TextStyle(fontSize: 12.0),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: MediaQuery.of(context).size.width * 0.045,
                ),
              )),
          TextButton(
              onPressed: () {},
              child: ListTile(
                title: const Text('I want to manage my order'),
                subtitle: const Text(
                  'Cancel, Change Delivery Date & Address',
                  style: TextStyle(fontSize: 12.0),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: MediaQuery.of(context).size.width * 0.045,
                ),
              )),
          TextButton(
              onPressed: () {},
              child: const ListTile(
                title: Text('I want help with returns & refunds'),
                subtitle: Text(
                  'Manage & Track Returns',
                  style: TextStyle(fontSize: 12.0),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                ),
              )),
          TextButton(
              onPressed: () {},
              child: const ListTile(
                title: Text('I want help with other issues'),
                subtitle: Text(
                  'Offers, Payments, Product Posts & Others',
                  style: TextStyle(fontSize: 12.0),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                ),
              )),
          TextButton(
              onPressed: () {},
              child: const ListTile(
                title: Text('I want to contact the seller'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                ),
              )),
        ],
      ),
    );
  }
}
