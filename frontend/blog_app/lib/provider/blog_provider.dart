import 'package:flutter/material.dart';

class BlogUpdateModel extends ChangeNotifier {
  // call this method whenever you want to update
  // blogs list
  void notify() {
    notifyListeners();
  }
}
