import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  int get value => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}