import 'package:examapp/service/auth_service.dart';
import 'package:flutter/material.dart';

class LoginController with ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String email = "";
  String password = "";

  Future<bool> login() async {
    if (isLoginValidate()) {
      bool result = await AuthService().login(email: email, password: password);
      if (result) {
        // giriş işlemi başarılı
        return true;
      }
      // giriş işlemi başarısız - firebase tarafından başarısız
      print("DEBUG: Firebase tarafından başarısız");
      return false;
    }
    print("DEBUG: Code tarafından başarısız");
    // giriş işlemi başarısız - source code tarafından başarısız
    return false;
  }

  Future<dynamic> currentUser() async {
    var user = await AuthService().currentUser();
    return user;
  }

  String validateEmail() {
    if (email.isEmpty) {
      return "Email can not be empty";
    }
    return null;
  }

  String validatePassword() {
    if (password.length < 6) {
      return "Password must be least 6 characters";
    }
    return null;
  }

  bool isLoginValidate() {
    return formKey.currentState.validate();
  }
}
