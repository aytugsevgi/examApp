import 'package:examapp/model/instructor.dart';
import 'package:examapp/service/user_service.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';

class AuthService {
  static final firebaseAuth = firebase.auth();

  Future<dynamic> signUp(
      {@required String email, @required String password}) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(email, password);
    } catch (e) {
      print("DEBUG: Error, AuthService signUp $e");
      return null;
    }
  }

  Future<bool> login(
      {@required String email, @required String password}) async {
    try {
      firebase.UserCredential authResult =
          await firebaseAuth.signInWithEmailAndPassword(email, password);

      if (authResult.user != null) {
        return true;
      }
      return false;
    } catch (e) {
      print("DEBUG: $e");
      return false;
    }
  }

  Future<dynamic> currentUser() async {
    var currentUser = firebaseAuth.currentUser;

    if (currentUser == null) {
      print("AAAAAAAA");
      currentUser = await firebaseAuth.onAuthStateChanged.first;
      print(
          "DEBUG: AuthService currentUserStateFirst is null ${currentUser == null}");
    }
    if (currentUser != null) {
      print("DEBUG: We have Current User");
      var user = await UserService().searchUser(currentUser.uid);
      return user;
    }
    print("DEBUG: We haven't Current User");
    return null;
  }

  Future<String> currentUserId() async {
    User currentUser = firebaseAuth.currentUser;

    if (currentUser != null) {
      return currentUser.uid;
    }
    return null;
  }

  Future<bool> singOut() async {
    try {
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("Sign out hata:" + e.toString());
      return false;
    }
  }
}
