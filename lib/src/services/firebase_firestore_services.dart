import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kkn_siwalan_mitra/src/model/product_model.dart';
import 'package:kkn_siwalan_mitra/src/services/firebase_storage_services.dart';
import 'package:uuid/uuid.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseStorageServices _firebaseStorageServices =
      FirebaseStorageServices();

  /// update user profile
  Future updateProfil({
    required BuildContext context,
    required String username,
    required String gender,
    required String alamat,
    required String rt,
    required String rw,
    required String kelurahan,
    required String nomorWhatsApp,
    String? error,
  }) async {
    try {
      await _firestore
          .collection('mitraUser')
          .doc(_firebaseAuth.currentUser!.uid)
          .update({
        'username': username,
        'jenisKelamin': gender,
        'alamat': alamat,
        'rt': rt,
        'rw': rw,
        'kelurahan': kelurahan,
        'nomorWhatsApp': nomorWhatsApp,
      });
    } on FirebaseException catch (e) {
      return error = e.toString();
    }
  }

  /// upload new product
  Future<void> uploadProduct({
    required String uid,
    required File file,
    required List<XFile> multipleXfile,
    required DateTime datePublished,
    required String productName,
    required String productDescrtiption,
    required String productLocation,
    required String productBenefit,
    required String productPrice,
    required String productCategory,
    required String productRW,
    required String productRT,
    required String sellerName,
    required String sellerContact,
    required String locationKelurahan,
  }) async {
    try {
      String photoUrl = await _firebaseStorageServices.uploadImage(
          childName: 'productMitra', file: file, isPost: true);

      List<String> listImage = await _firebaseStorageServices
          .uploadMuiltipleImageFiles(multipleXfile);

      String productId = const Uuid().v1();
      ProductModel productModel = ProductModel(
        uid: uid,
        productId: productId,
        productName: productName,
        productImage: photoUrl,
        productGridImage: listImage,
        productDescrtiption: productDescrtiption,
        productLocation: productLocation,
        productBenefit: productBenefit,
        productPrice: productPrice,
        productCategory: productCategory,
        productRW: productRW,
        productRT: productRT,
        sellerName: sellerName,
        datePublished: datePublished,
        sellerContact: sellerContact,
        locationKelurahan: locationKelurahan,
      );
      debugPrint(listImage.toString());
      await _firestore
          .collection("productMitra")
          .doc(productId)
          .set(productModel.toJson());
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Delete Post
  Future<void> deleteProduct({
    required String productId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('productMitra')
          .doc(productId)
          .delete();
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }

// /// edit product
// Future updateProduct({
//   required String uid,
//   required String productName,
//   required File productImage,
//   required String productDescrtiption,
//   required String productLocation,
//   required String productBenefit,
//   required String productPrice,
//   required List productCategory,
//   required String productRW,
//   required String productRT,
//   required String sellerName,
//   required String sellerContact,
//   required DateTime datePublished,
//   required List<XFile> multipleXfile,
// }) async {
//   String photoUrl = await _firebaseStorageServices.uploadImage(
//       childName: 'productMitra', file: productImage, isPost: true);
//
//   List<String> listImage = await _firebaseStorageServices
//       .uploadMuiltipleImageFiles(multipleXfile);
//   await _firestore
//       .collection('productMitra')
//       .doc('productId')
//       .update({
//     "productId": uid,
//     "productName": productName,
//     "productImage": photoUrl,
//     "productGridImage": listImage,
//     "productDescription": productDescrtiption,
//     "productLocation": productLocation,
//     "productBenefit": productBenefit,
//     "productPrice": productPrice,
//     "productCategory": productCategory,
//     "productRW": productRW,
//     "productRT": productRT,
//     "sellerName": sellerName,
//     "sellerContact": sellerContact,
//     "datePublished": datePublished,
//   });
// }
}
