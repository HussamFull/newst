import 'package:flutter/material.dart';


mixin SafeNotify on ChangeNotifier {
  bool isDisposed = false;
  void notify() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  
}