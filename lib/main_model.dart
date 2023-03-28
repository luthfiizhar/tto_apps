import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  int _indexPage = 0;

  int get indexPage => _indexPage;

  void setIndexPage(value) {
    _indexPage = value;
    notifyListeners();
  }
}
