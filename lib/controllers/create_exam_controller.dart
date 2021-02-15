import 'package:examapp/controllers/create_question_controller.dart';
import 'package:examapp/model/classroom.dart';
import 'package:examapp/model/current_user.dart';
import 'package:examapp/service/classroom_service.dart';
import 'package:examapp/service/exam_service.dart';
import 'package:examapp/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateExamController with ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String name = "";
  DateTime _startDate;
  DateTime _dueDate;
  get startDate => _startDate;
  set startDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  get dueDate => _dueDate;
  set dueDate(DateTime value) {
    _dueDate = value;
    notifyListeners();
  }

  Future<bool> createExam(
      BuildContext context,
      List<Map<String, List<Map<String, bool>>>> questionList,
      Classroom classroom) async {
    try {
      print("DEBUG: DUE DATE: ${dueDate.toString()}");
      String examId = await ExamService()
          .createExam(name, startDate, dueDate, questionList, classroom);
      await ClassroomService().addExamToClassroom(classroom, examId);
      context.read<CreateQuestionController>().resetData();
      return true;
    } catch (e) {
      return false;
    }
  }

  String dateToString(DateTime dateTime) {
    if (dateTime != null) {
      return "${dateTime.day.force2digitToString}-${dateTime.month.force2digitToString}-${dateTime.year.force2digitToString}  ${dateTime.hour.force2digitToString}:${dateTime.minute.force2digitToString}";
    }
    return "";
  }

  void resetData() {
    name = "";
    startDate = null;
    dueDate = null;
  }

  String validateName() {
    if (name.length < 3) {
      return "Exam name must be least 3 characters";
    }
    return null;
  }

  bool isCreateExamValidate() {
    return formKey.currentState.validate() &&
        _startDate != null &&
        _dueDate != null;
  }
}
