import 'package:examapp/model/classroom.dart';
import 'package:examapp/model/current_user.dart';
import 'package:examapp/model/student.dart';
import 'package:examapp/service/classroom_service.dart';
import 'package:examapp/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ClassroomController with ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  GlobalKey<FormState> joinFormKey = new GlobalKey<FormState>();
  PageController pageController = new PageController();
  Classroom _selectedClassroom = Classroom(name: "", id: "");
  String accessCode = "";
  String name = "";

  get selectedClassroom => _selectedClassroom;

  set selectedClassroom(Classroom classroom) {
    _selectedClassroom = classroom;
    notifyListeners();
  }

  String validateName() {
    if (name.length < 3) {
      return "Class name must be least 3 characters";
    }
    return null;
  }

  String validateAccessCode() {
    if (accessCode.length < 3) {
      return "Invalid access code";
    }
    return null;
  }

  bool isCreateClassroomValidate() {
    return formKey.currentState.validate();
  }

  bool isJoinClassroomValidate() {
    return joinFormKey.currentState.validate();
  }

  Future<bool> createClassroom() async {
    if (isCreateClassroomValidate()) {
      print("DEBUG: Form Validate");
      var uuid = Uuid();
      String id = uuid.v1();
      Classroom classroom = new Classroom(id: id, name: name);
      bool isSuccess = await ClassroomService().createClassroom(classroom);
      return isSuccess;
    }
    print("Not Validate");
    return false;
  }

  Future<String> joinClassroom() async {
    if (isJoinClassroomValidate()) {
      Classroom classroom =
          await ClassroomService().searchClassroom(id: accessCode);
      print("DEBUG: Classroom founded: ${classroom.name}");
      if (classroom != null) {
        Student student = CurrentUser.currentUser;
        List<String> classrooms = student.classes.cast<String>() ?? [];
        classrooms.add(classroom.id);
        student.classes = classrooms;
        bool isSuccess = await UserService().updateUser(student);
        if (isSuccess) {
          return null;
        }
        return "User informations didn't update";
      }
      return "Invalid access code";
    }
    return "";
  }

  Future<List<Classroom>> getUserClassrooms() async {
    return await ClassroomService().getUserClassrooms();
  }
}
