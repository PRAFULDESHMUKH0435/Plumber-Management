import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  int counter = 0;

  incrementCounter() {
    counter++;
    notifyListeners();
  }

   resetCounter() {
    counter=0;
    notifyListeners();
  }
}
