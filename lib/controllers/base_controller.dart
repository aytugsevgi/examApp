import 'package:flutter/material.dart';

enum TabType {
  Home,
  Classroom,
  Contact,
  About,
}

class BaseController with ChangeNotifier {
  TabType _selectedTab = TabType.Home;

  get selectedTab => _selectedTab;
  set selectedTab(TabType value) {
    _selectedTab = value;
    notifyListeners();
  }
}
