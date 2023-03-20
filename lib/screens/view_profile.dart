import 'package:c2c_project1/components/profile_generator.dart';
import 'package:c2c_project1/screens/profile.dart';
import 'package:flutter/material.dart';

class ViewsProfile extends StatefulWidget {
  const ViewsProfile({Key? key}) : super(key: key);

  @override
  State<ViewsProfile> createState() => _ViewsProfileState();
}

class _ViewsProfileState extends State<ViewsProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: ProfileViewGenerator(
        id: user?.uid,
      ),
    );
  }
}
