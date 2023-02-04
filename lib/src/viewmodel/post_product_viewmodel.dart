import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kkn_siwalan_mitra/src/services/firebase_firestore_services.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';
import 'package:kkn_siwalan_mitra/src/widget/custom_dialogs.dart';

class PostProductViewModel with ChangeNotifier {
  File? _images;

  File? get images => _images;

  /// pick single image
  Future<void> pickLeadImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    _images = File(pickedImage!.path);
    notifyListeners();
    debugPrint(_images!.path);
  }

  final List<XFile> _multipleImage = [];

  List<XFile> get multipleImage => _multipleImage;

  /// pick multiple image
  Future<void> pickMultipleImage() async {
    final ImagePicker multiplePicker = ImagePicker();
    final List<XFile> pickMultiple = await multiplePicker.pickMultiImage(
      imageQuality: 30,
    );
    if (pickMultiple.isNotEmpty) {
      _multipleImage.addAll(pickMultiple);
    }
    notifyListeners();
    debugPrint(pickMultiple.length.toString());
  }

  /// reset foto
  void resetMultipleImage() {
    _multipleImage.clear();
    notifyListeners();
  }

  ///------------------------------------------------------------------------
  /// categori

  final bool _selected = false;

  bool get selected => _selected;

  final List<String> _kategoriList = [
    'Makanan Ringan',
    'Makanan',
    'Minuman',
    'Kebersihan',
    'Kesehatan',
    'Kecantikan',
    'Fashion',
    'Kerajinan Tangan',
    'Lainnya',
  ];

  List<String> get kategoriList => _kategoriList;

  final List<dynamic> _selectionCategory = [];

  List get selectionCategory => _selectionCategory;

  void addCategories(String value) {
    _selectionCategory.add(value);
    notifyListeners();
  }

  /// remove catalog
  void removeCateogries(String value) {
    _selectionCategory.remove(value);
    notifyListeners();
  }

  void clearCategories() {
    _selectionCategory.clear();
    notifyListeners();
  }

  /// -----------------------------------------------------------------------

  bool _isUpload = false;

  bool get isUpload => _isUpload;

  /// upload product
  Future<void> uploadNewProduct({
    required BuildContext context,
    required String uid,
    required String productName,
    required String productDescrtiption,
    required String productLocation,
    required String productBenefit,
    required String productPrice,
    required List productCategory,
    required String productRW,
    required String productRT,
    required String sellerName,
    required String sellerContact,
    TextEditingController? usernameController,
    TextEditingController? descriptionController,
    TextEditingController? benefitController,
    TextEditingController? priceController,
  }) async {
    _isUpload = !_isUpload;
    notifyListeners();
    try {
      await FirestoreServices().uploadProduct(
        uid: uid,
        file: _images!,
        multipleXfile: multipleImage,
        productName: productName,
        productDescrtiption: productDescrtiption,
        productLocation: productLocation,
        productBenefit: productBenefit,
        productPrice: productPrice,
        productCategory: productCategory,
        productRW: productRW,
        productRT: productRT,
        sellerName: sellerName,
        datePublished: DateTime.now(),
        sellerContact: sellerContact,
      );
      _isUpload = false;

      Future.delayed(const Duration(milliseconds: 700), () {
        _multipleImage.clear();
        _images = null;
        _selectionCategory.clear();
        usernameController!.clear();
        descriptionController!.clear();
        benefitController!.clear();
        priceController!.clear();
        notifyListeners();
      });

      CustomDialogs().customDialog(
        context: context,
        image: 'success',
        title: 'Produk berhasil di upload',
        textButton1: 'Oke',
        textButton2: '',
        bgSingleButton: MyColor.warning500,
        singleButton: true,
        singleOnpressed: () {
          Navigator.pop(context);
        },
      );

      notifyListeners();
    } on FirebaseException catch (e) {
      CustomDialogs().customDialog(
        context: context,
        image: 'error',
        title: e.toString(),
        textButton1: 'Oke',
        textButton2: '',
        bgSingleButton: MyColor.danger400,
        singleButton: true,
        singleOnpressed: () {
          Navigator.pop(context);
        },
      );
      _isUpload = false;
      notifyListeners();
    }
  }
}
