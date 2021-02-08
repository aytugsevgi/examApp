import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/model/classroom.dart';
import 'package:examapp/model/current_user.dart';
import 'package:examapp/model/instructor.dart';
import 'package:examapp/model/student.dart';

class ClassroomService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createClassroom(Classroom classroom) async {
    try {
      await _firestore
          .collection("classrooms")
          .doc(classroom.id)
          .set(classroom.toJson());
    } catch (e) {
      print("DEBUG couldn't createClassroom $e");
      return false;
    }
    try {
      Instructor instructor = CurrentUser.currentUser;
      List<String> classes = instructor.classes.cast<String>();
      classes.add(classroom.id);
      instructor.classes = classes;
      print("DEBUG: A1");
      await _firestore
          .collection("instructors")
          .doc(CurrentUser.currentUser.userId)
          .set(instructor.toJson());
      print("DEBUG: A2");
      return true;
    } catch (e) {
      print("DEBUG: couldn't createClassroom Instructor classes $e");
      return false;
    }
  }

  Future<Classroom> searchClassroom({String id}) async {
    try {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection("classrooms")
          .doc(id)
          .get();
      Classroom classroom = Classroom.fromJson(document.data());
      return classroom;
    } catch (e) {
      print("DEBUG: Error searchClassroom $e");
      return null;
    }
  }

  Future<List<Classroom>> getUserClassrooms() async {
    var user = CurrentUser.currentUser;
    List<Classroom> classrooms = [];
    try {
      if (user is Instructor) {
        for (String id in user.classes) {
          DocumentSnapshot document = await FirebaseFirestore.instance
              .collection("classrooms")
              .doc(id)
              .get();
          Classroom classroom = Classroom.fromJson(document.data());
          classrooms.add(classroom);
        }
      } else if (user is Student) {
        for (String id in user.classes) {
          DocumentSnapshot document = await FirebaseFirestore.instance
              .collection("classrooms")
              .doc(id)
              .get();
          Classroom classroom = Classroom.fromJson(document.data());
          classrooms.add(classroom);
        }
      }
      return classrooms;
    } catch (e) {
      print("DEBUG: Error ClassroomService getUserClassroms $e");
      return [];
    }
  }
}
