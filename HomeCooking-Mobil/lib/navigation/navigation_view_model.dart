import 'package:flutter/material.dart';

enum NavigationState { busy, idle, error }

class NavigationViewModel with ChangeNotifier {
  int navigationIndex = 4;

  NavigationState _state = NavigationState.idle;

  NavigationState get state => _state;

  set state(NavigationState state) {
    _state = state;
    notifyListeners();
  }

  void changeNavigationIndex(int newIndex) {
    navigationIndex = newIndex;
    notifyListeners();
  }
}
