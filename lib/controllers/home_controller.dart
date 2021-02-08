import 'package:examapp/service/auth_service.dart';
import 'package:flutter/material.dart';

enum HomeSelectedView {
  Welcome,
  Login,
  Register,
  Instructor,
  Student,
}

class HomeController with ChangeNotifier {
  HomeSelectedView _homeSelectedView = HomeSelectedView.Welcome;

  get homeSelectedView => _homeSelectedView;
  set homeSelectedView(HomeSelectedView value) {
    _homeSelectedView = value;
    notifyListeners();
  }
}
