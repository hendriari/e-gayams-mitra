import 'package:flutter/cupertino.dart';

class PostProductViewModel with ChangeNotifier {
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
}
