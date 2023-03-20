import 'dart:io';
import 'package:c2c_project1/screens/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';

late String userId;
final FirebaseStorage storage = FirebaseStorage.instance;
late String draftImageUrl;

class Storage {
  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);

    try {
      await storage.ref('${user?.email}/$fileName').putFile(file);
    } catch (e) {
      if (kDebugMode) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  Future<String> downloadUrl(String imageName) async {
    String downloadUrl =
        await storage.ref('${user?.email}/$imageName').getDownloadURL();

    draftImageUrl = downloadUrl;
    return downloadUrl;
  }
}
