import 'dart:io';
import 'package:dio/dio.dart';
import 'package:module_data/src/core/exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageService {
  final storageRef = FirebaseStorage.instance.ref();

  Future<void> uploadProfilePicture(String imagePath) async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final profilePictureRef =
        storageRef.child("profilePictures/$userUid/avatar.jpg");
    File file = File(imagePath);
    try {
      await profilePictureRef.putFile(file);
      return Future.value();
    } on FirebaseException catch (e) {
      throw UserProfileException.fromCode(e.code);
    }
  }

  Future<void> deleteProfilePicture() async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final profilePictureRef =
        storageRef.child("profilePictures/$userUid/avatar.jpg");
    try {
      await profilePictureRef.delete();
      return Future.value();
    } on FirebaseException catch (e) {
      throw UserProfileException.fromCode(e.code);
    }
  }

  Future<String> getProfilePictureURL() {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final profilePictureRef =
        storageRef.child("profilePictures/$userUid/avatar.jpg");
    return profilePictureRef.getDownloadURL();
  }

  Future<String> downloadProfilePicture() async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;
    final profilePictureRef =
        storageRef.child("profilePictures/$userUid/avatar.jpg");
    final imagePath = '${(await getTemporaryDirectory()).path}avatar.jpg';
    final downloadURL = await profilePictureRef.getDownloadURL();
    await Dio().download(downloadURL, imagePath);
    return imagePath;
  }
}
