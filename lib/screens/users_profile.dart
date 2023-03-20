import 'package:flutter/material.dart';
import '../components/profile_generator.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key, required this.username, required this.uID})
      : super(key: key);

  final String username;
  final String uID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: ProfileViewGenerator(
        id: uID,
      ),
    );
  }
}
