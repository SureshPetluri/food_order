import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  int count = 0;

  bottomNavSelection(int value) {
    count = value;
    notifyListeners();
  }
}
