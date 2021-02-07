import 'package:examapp/model/instructor.dart';
import 'package:examapp/model/student.dart';
import 'package:examapp/service/auth_service.dart';
import 'package:examapp/service/user_service.dart';
import 'package:flutter/material.dart';

class RegisterController with ChangeNotifier {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  String _name = "";
  String _lastname = "";
  bool isStudent = true;

  get formKey => _formKey;
  String get email => _email;

  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get name => _name;
  String get lastname => _lastname;

  set email(String value) => _email = value;

  set password(String value) => _password = value;
  set confirmPassword(String value) => _confirmPassword = value;
  set name(String value) => _name = value;
  set lastname(String value) => _lastname = value;

  bool validateRegister() {
    return _formKey.currentState.validate();
  }

  String nameValidator() {
    if (_name.isEmpty) {
      return "Name can't be empty";
    }
    return null;
  }

  String lastnameValidator() {
    if (_lastname.isEmpty) {
      return "Lastname can't be empty";
    }
    return null;
  }

  String emailValidator() {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      return "Invalid Email";
    }
  }

  String passwordValidator() {
    if (_password.length < 6) {
      return "Password must be least at 6 characters";
    }
    return null;
  }

  String confirmPasswordValidator() {
    if (_password != _confirmPassword) {
      return "Confirm password and password not matched";
    }
    return null;
  }

  Future<bool> register() async {
    if (!validateRegister()) {
      print("DEBUG: Register isn't validate");
      return false;
    }
    print("DEBUG: Register isn validate");

    dynamic _authResult =
        await AuthService().signUp(email: _email, password: _password);
    print("DEBUG: AuthResult ${_authResult.toString()}");

    if (_authResult != null) {
      var user;
      if (isStudent) {
        user = new Student(
            firstName: _name,
            lastName: lastname,
            email: _email,
            userId: _authResult.user.uid);
      } else {
        user = new Instructor(
            firstName: _name,
            lastName: _lastname,
            email: _email,
            userId: _authResult.user.uid);
      }

      return UserService().saveUser(user);
    }
    return false;
  }
}
