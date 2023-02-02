import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// upload image to firestorage
  Future<String> uploadImage({
    required String childName,
    required File file,
    required bool isPost,
  }) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  Future<List<String>> uploadMuiltipleImageFiles(List<XFile> listImages) async {
    var imageUrls = await Future.wait(
      listImages.map(
        (image) => uploadMultipleImage(image),
      ),
    );
    debugPrint('$imageUrls');
    return imageUrls;
  }

  Future<String> uploadMultipleImage(XFile xfile) async {
    Reference storageReference =
        _storage.ref().child('listImage/${xfile.path}');
    UploadTask uploadTask = storageReference.putFile(
      File(xfile.path),
    );
    TaskSnapshot taskSnapshot = await uploadTask;
   return await taskSnapshot.ref.getDownloadURL();
  }
}
