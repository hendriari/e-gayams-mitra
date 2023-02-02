import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String username;
  String email;
  String jenisKelamin;
  String alamat;
  String rt;
  String rw;
  String nomorWhatsApp;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.jenisKelamin,
    required this.alamat,
    required this.rt,
    required this.rw,
    required this.nomorWhatsApp,
  });

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot["uid"],
      username: snapshot["username"],
      email: snapshot["email"],
      jenisKelamin: snapshot["jenisKelamin"],
      alamat: snapshot["alamat"],
      rt: snapshot["rt"],
      rw: snapshot["rw"],
      nomorWhatsApp: snapshot["nomorWhatsApp"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "jenisKelamin": jenisKelamin,
        "alamat": alamat,
        "rt": rt,
        "rw": rw,
        "nomorWhatsApp": nomorWhatsApp,
      };
}
