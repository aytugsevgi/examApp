import 'package:examapp/model/classroom.dart';
import 'package:examapp/model/current_user.dart';
import 'package:examapp/model/exam.dart';
import 'package:examapp/model/student.dart';
import 'package:examapp/service/classroom_service.dart';
import 'package:examapp/service/exam_service.dart';
import 'package:examapp/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ClassroomController with ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  GlobalKey<FormState> joinFormKey = new GlobalKey<FormState>();
  PageController pageController = new PageController();
  PageController pageController2 = new PageController();
  Classroom _selectedClassroom = Classroom(name: "", id: "");
  String accessCode = "";
  String name = "";
  String _joinClassError = "";

  get selectedClassroom => _selectedClassroom;

  set selectedClassroom(Classroom classroom) {
    _selectedClassroom = classroom;
    notifyListeners();
  }

  get joinClassError => _joinClassError;

  set joinClassError(String value) {
    _joinClassError = value;
    notifyListeners();
  }

  String validateName() {
    if (name.length < 3) {
      return "Class name must be least 3 characters";
    }
    return null;
  }

  String validateAccessCode() {
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
      Classroom classroom = new Classroom(id: id, name: name, exams: []);
      bool isSuccess = await ClassroomService().createClassroom(classroom);
      return isSuccess;
    }
    print("Not Validate");
    return false;
  }

  Future<bool> joinClassroom() async {
    if (isJoinClassroomValidate()) {
      Classroom classroom =
          await ClassroomService().searchClassroom(id: accessCode);
      if (classroom != null) {
        Student student = CurrentUser.currentUser;
        List<String> classrooms = student.classes.cast<String>() ?? [];
        classrooms.add(classroom.id);
        student.classes = classrooms;
        bool isSuccess = await UserService().updateUser(student);
        if (isSuccess) {
          joinClassError = "";
          return true;
        }
        joinClassError = "User informations didn't update";
        return false;
      }
      joinClassError = "Invalid access code";
      return false;
    }
    // input validate olmadığı için db ile ilgili bir hata göstermiyoruz.
    joinClassError = "";
    return false;
  }

  Future<List<Classroom>> getUserClassrooms() async {
    return await ClassroomService().getUserClassrooms();
  }

  Future<List<Exam>> getClassroomExams(String classId) async {
    Classroom classroom = await ClassroomService().searchClassroom(id: classId);
    List<Exam> examList = [];
    for (String examId in classroom.exams) {
      Exam exam = await ExamService().getExam(examId);
      exam.isSubmitted = await ExamService().isCurrentUserSubmitted(examId);
      examList.add(exam);
    }
    examList.sort((a, b) => a.startDate.isBefore(b.startDate) ? 1 : -1);
    return examList;
  }
}
