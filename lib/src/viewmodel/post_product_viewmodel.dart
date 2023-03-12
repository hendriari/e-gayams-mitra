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
      imageQuality: 30,
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
      imageQuality: 20,
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

  /// -----------------------------------------------------------------------
  List locationKelurahan = [
    'Kel. Siwalan',
    'Kel. Gayamsari',
    'Kel. Sambirejo',
    'Kel. Pandean Lamper',
    'Kel. Sawah Besar',
    'Kel. Tambakrejo',
    'Kel. Kaligawe',
  ];

  ///------------------------------------------------------------------------
  /// categori

  final bool _selected = false;

  bool get selected => _selected;

  final List _titleKategoriList = [
    'Makanan Ringan',
    'Makanan',
    'Minuman',
    'Kesehatan',
    'Kecantikan',
    'Fashion',
    'Kerajinan Tangan',
    'Kategori Lainnya',
  ];

  List get titleKategoriList => _titleKategoriList;

  final List _imageKategoriList = [
    'assets/image/makanan_ringan.png',
    'assets/image/makanan.png',
    'assets/image/minuman.png',
    'assets/image/kesehatan.png',
    'assets/image/kecantikan.png',
    'assets/image/fashion.png',
    'assets/image/handycraft.png',
    'assets/image/any.png',
  ];

  List get imageKategoriList => _imageKategoriList;

  /// note : keep untuk catatan pribadi
  // final List<dynamic> _selectionCategory = [];
  //
  // List get selectionCategory => _selectionCategory;
  //
  // void addCategories(String value) {
  //   _selectionCategory.add(value);
  //   notifyListeners();
  // }
  //
  // /// remove catalog
  // void removeCateogries(String value) {
  //   _selectionCategory.remove(value);
  //   notifyListeners();
  // }
  //
  // void clearCategories() {
  //   _selectionCategory.clear();
  //   notifyListeners();
  // }

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
    required String productCategory,
    required String productRW,
    required String productRT,
    required String sellerName,
    required String sellerContact,
    required String locationKelurahan,
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
        locationKelurahan: locationKelurahan,
      );
      _isUpload = false;

      Future.delayed(const Duration(milliseconds: 700), () {
        _multipleImage.clear();
        _images = null;
        usernameController!.clear();
        descriptionController!.clear();
        benefitController!.clear();
        priceController!.clear();
        notifyListeners();
      });

      Future.delayed(
        Duration.zero,
        () => CustomDialogs().customDialog(
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
        ),
      );

      notifyListeners();
    } on FirebaseException catch (e) {
      CustomDialogs().customDialog(
        context: context,
        image: 'error',
        title: e.message!,
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
