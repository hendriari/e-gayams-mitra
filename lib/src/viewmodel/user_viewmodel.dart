import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan_mitra/src/model/user_model.dart';
import 'package:kkn_siwalan_mitra/src/services/firebase_auth_services.dart';

class UserViewModel with ChangeNotifier {
  final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();

  UserModel? _userModel;

  UserModel? get usermodel => _userModel;

  Future refreshUsers() async {
    UserModel userModels = await _firebaseAuthServices.getUserDetail();
    _userModel = userModels;
    notifyListeners();
  }

  /// get user data from firestore
  final Stream<DocumentSnapshot<Map<String, dynamic>>> _userData =
      FirebaseFirestore.instance
          .collection('userPhase2')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots();

  get userData => _userData;
}
