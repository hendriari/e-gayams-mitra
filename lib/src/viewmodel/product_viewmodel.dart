import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan_mitra/src/services/firebase_firestore_services.dart';
import 'package:kkn_siwalan_mitra/src/widget/response_dialog.dart';

class ProductViewModel with ChangeNotifier {
  final _getProduct = FirebaseFirestore.instance
      .collection('productMitra')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  get getProduct => _getProduct;

  /// get user detail
  // Future<UserModel> getUserDetail() async {
  //   User currentUser = FirebaseAuth.instance.currentUser!;
  //
  //   DocumentSnapshot documentSnapshot =
  //   await _firestore.collection('mitraUser').doc(currentUser.uid).get();
  //
  //   return UserModel.fromSnap(documentSnapshot);
  // }

  // Future<ProductModel> getAllProduct() async {
  //
  //
  //  // DocumentSnapshot documentSnapshot = FirebaseFirestore.instance
  //  //      .collection('productMitra')
  //  //      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //  //      .get();
  //
  //   // DocumentSnapshot documentSnapshot =
  //   // FirebaseFirestore.instance.collection('mitraUser').where('uid', is)
  //
  //   return ProductModel.fromSnap(documentSnapshot);
  // }

  /// delete product
  void deleteProductById({
    required BuildContext context,
    required String productId,
  }) async {
    try {
      await FirestoreServices().deleteProduct(productId: productId);
      ResponseDialog.responseInfoDialog(
        context: context,
        image: 'success.png',
        description: 'Berhasil dihapus',
      );
      notifyListeners();
    } on FirebaseException catch (e) {
      ResponseDialog.responseInfoDialog(
        context: context,
        image: 'cancel.png',
        description: e.message!,
      );
    }
  }
}
