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
