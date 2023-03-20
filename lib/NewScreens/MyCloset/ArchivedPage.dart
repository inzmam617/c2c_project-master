import 'package:flutter/material.dart';

class ArchivedPage extends StatefulWidget {
  const ArchivedPage({Key? key}) : super(key: key);

  @override
  State<ArchivedPage> createState() => _ArchivedPageState();
}

class _ArchivedPageState extends State<ArchivedPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Archived Page"),
      ),
    );
  }
}
