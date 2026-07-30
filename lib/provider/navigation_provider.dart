import 'package:flutter/widgets.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void updateIndex (int updatedIndex) {
    _currentIndex = updatedIndex;
    notifyListeners();
  }
}