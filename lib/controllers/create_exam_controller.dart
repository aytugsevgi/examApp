import 'package:examapp/utils/extension.dart';
import 'package:flutter/material.dart';

class CreateExamController with ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String name = "";
  int questionCount;
  int examDuration;
  DateTime _startDate;

  get startDate => _startDate;
  set startDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  String startDateToString() {
    if (_startDate != null) {
      return "${_startDate.day.force2digitToString}-${_startDate.month.force2digitToString}-${_startDate.year.force2digitToString}  ${_startDate.hour.force2digitToString}:${_startDate.minute.force2digitToString}";
    }
    return "";
  }

  void resetData() {
    name = "";
    questionCount = null;
    examDuration = null;
    startDate = null;
  }

  String validateName() {
    if (name.length < 3) {
      return "Exam name must be least 3 characters";
    }
    return null;
  }

  String validateQuestionCount() {
    if (questionCount == null || questionCount < 2) {
      return "Question count must be least at 1";
    }
    return null;
  }

  String validateExamDuration() {
    if (examDuration == null || examDuration < 2) {
      return "Exam duration must be least at 1 minute";
    }
    return null;
  }

  bool isCreateExamValidate() {
    return formKey.currentState.validate();
  }
}
