import 'package:flutter/material.dart';

class CreateQuestionController with ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String questionTitle = "";
  List<String> answer = ["", "", "", "", ""];
  List<bool> answerKey = [false, false, false, false, false];
  List<Map<String, List<Map<String, bool>>>> questionAnswerList = [];
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool isQuestionValidate() {
    return formKey.currentState.validate();
  }

  String validateTitle() {
    if (questionTitle.isEmpty) {
      return "Question title can't be empty";
    }
    return null;
  }

  void deleteQuestion(int index) {
    questionAnswerList.removeAt(index);
    notifyListeners();
  }

  void changeCorrectAnswer(int index) {
    for (var i = 0; i < answerKey.length; i++) {
      answerKey[i] = false;
    }
    answerKey[index] = true;
    notifyListeners();
  }

  void saveQuestion() {
    questionAnswerList.add({
      questionTitle: [
        {answer[0]: answerKey[0]},
        {answer[1]: answerKey[1]},
        {answer[2]: answerKey[2]},
        {answer[3]: answerKey[3]},
        {answer[4]: answerKey[4]},
      ]
    });
    answer = ["", "", "", "", ""];
    answerKey = [false, false, false, false, false];
    questionTitle = "";
    for (var controller in controllers) {
      controller.clear();
    }
    notifyListeners();
  }
}
