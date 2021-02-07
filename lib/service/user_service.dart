import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/model/instructor.dart';
import 'package:examapp/model/student.dart';

class UserService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> saveUser(dynamic user) async {
    if (user is Instructor) {
      try {
        await _firestore
            .collection("instructors")
            .doc(user.userId)
            .set(user.toJson());
        return true;
      } catch (e) {
        print("DEBUG couldn't save $e");
        return false;
      }
    } else if (user is Student) {
      try {
        await _firestore
            .collection("students")
            .doc(user.userId)
            .set(user.toJson());
        return true;
      } catch (e) {
        print("DEBUG couldn't save $e");
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> updateUser(dynamic user) async {
    if (user is Instructor) {
      try {
        await _firestore
            .collection('instructors')
            .doc(user.userId)
            .set(user.toJson());
        return true;
      } catch (e) {
        print("DEBUG: Error UserService updateUser: $e");
        return false;
      }
    } else if (user is Student) {
      try {
        await _firestore
            .collection('students')
            .doc(user.userId)
            .set(user.toJson());
        return true;
      } catch (e) {
        print("DEBUG: Error UserService updateUser: $e");
        return false;
      }
    } else {
      return false;
    }
  }

  Future<dynamic> searchUser(String uid) async {
    try {
      DocumentSnapshot currentUser =
          await _firestore.collection("instructors").doc(uid).get();

      if (currentUser.data() == null) {
        currentUser = await _firestore.collection("students").doc(uid).get();
        Map<String, dynamic> temp = currentUser.data();
        Student user = Student.fromJson(temp);
        return user;
      }
      Map<String, dynamic> temp = currentUser.data();
      Instructor user = Instructor.fromJson(temp);
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<List<DocumentSnapshot>> searchUserFromEmail(String searchText) async {
    try {
      List<DocumentSnapshot> documentList = (await FirebaseFirestore.instance
              .collection("students")
              .where("email", isEqualTo: searchText)
              .get())
          .docs;

      int length = documentList.length;

      print("DEBUG: length of users $length");

      return documentList;
    } catch (e) {
      return null;
    }
  }
}
