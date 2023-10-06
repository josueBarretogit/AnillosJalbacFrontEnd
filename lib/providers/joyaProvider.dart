import 'package:flutter/material.dart';

class JoyaProvider extends ChangeNotifier {
  JoyaProvider();

  String joya = '';

  String get getJoya => joya;

  void setJoya(String joyaABuscar) {
    joya = joyaABuscar;
    notifyListeners();
  }
}
