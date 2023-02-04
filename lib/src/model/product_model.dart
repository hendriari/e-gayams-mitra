import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String uid;
  String productId;
  String productName;
  String productImage;
  List<String> productGridImage;
  String productDescrtiption;
  String productLocation;
  String productBenefit;
  String productPrice;
  List productCategory;
  String productRW;
  String productRT;
  String sellerName;
  String sellerContact;
  DateTime datePublished;

  ProductModel({
    required this.uid,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productGridImage,
    required this.productDescrtiption,
    required this.productLocation,
    required this.productBenefit,
    required this.productPrice,
    required this.productCategory,
    required this.productRW,
    required this.productRT,
    required this.sellerName,
    required this.datePublished,
    required this.sellerContact,
  });

  static ProductModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ProductModel(
      uid: snapshot["uid"],
      productId: snapshot["productId"],
      productName: snapshot["productName"],
      productImage: snapshot["productImage"],
      productGridImage: snapshot["productGridImage"],
      productDescrtiption: snapshot["productDescription"],
      productLocation: snapshot["productLocation"],
      productBenefit: snapshot["productBenefit"],
      productPrice: snapshot["productPrice"],
      productCategory: snapshot["productCategory"],
      productRW: snapshot["productRW"],
      productRT: snapshot["productRT"],
      sellerName: snapshot["sellerName"],
      sellerContact: snapshot["sellerContact"],
      datePublished: snapshot["datePublished"],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "productId": productId,
        "productName": productName,
        "productImage": productImage,
        "productGridImage": productGridImage,
        "productDescription": productDescrtiption,
        "productLocation": productLocation,
        "productBenefit": productBenefit,
        "productPrice": productPrice,
        "productCategory": productCategory,
        "productRW": productRW,
        "productRT": productRT,
        "sellerName": sellerName,
        "sellerContact": sellerContact,
        "datePublished": datePublished,
      };
}
