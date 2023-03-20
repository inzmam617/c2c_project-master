import 'package:c2c_project1/screens/archived_products.dart';
import 'package:c2c_project1/screens/product_4sale.dart';
import 'package:c2c_project1/screens/product_drafts.dart';
import 'package:flutter/material.dart';
import 'storageManager.dart';

class SellPage extends StatefulWidget {
  const SellPage({Key? key}) : super(key: key);

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              bottom: const TabBar(
                tabs: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "For Sale",
                      style: TextStyle(
                        fontFamily: "Ubuntu",
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Text(
                    "Archived",
                    style: TextStyle(
                      fontFamily: "Ubuntu",
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    "Drafts",
                    style: TextStyle(
                      fontFamily: "Ubuntu",
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text("My Closet"),
                ],
              ),
            ),
            body: const TabBarView(
              children: <Widget>[
                ForSaleProduct(), //change storage to separate file
                ArchivedProducts(),
                DraftProduct(),
              ],
            ),
          ),
        ),
      );
}
