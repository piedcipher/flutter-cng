import 'package:flutter/material.dart';

class AppChangeNotifier extends ChangeNotifier {
  Brightness _brightness = Brightness.light;

  Brightness get brightness => _brightness;

  set brightness(Brightness brightness) {
    _brightness = brightness;
    notifyListeners();
  }
}
