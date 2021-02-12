import 'dart:async';

import 'package:examapp/model/answer.dart';
import 'package:examapp/model/exam.dart';
import 'package:examapp/model/question.dart';
import 'package:examapp/service/exam_service.dart';
import 'package:flutter/material.dart';

class ExamController with ChangeNotifier {
  Exam exam;
  List<Map<Question, List<Answer>>> questions = [];
  List<String> answerList = [];
  int remainTimeMin = 0;
  int remainTimeSec = 0;
  Timer _timer;
  void setAnswer(int index, String id) {
    answerList[index] = id;
    notifyListeners();
  }

  void startRemainTime() {
    Duration duration = exam.dueDate.difference(DateTime.now());
    int _start = duration.inSeconds;
    remainTimeMin = (_start / 60).ceil();
    remainTimeSec = _start % 60;
    int tempRemain;
    const oneDecimal = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneDecimal, (Timer timer) {
      if (_start < 1) {
        remainTimeMin = 0;
        notifyListeners();
        _timer.cancel();
      } else {
        _start -= 1;
        tempRemain = (_start / 60).ceil();
        remainTimeSec = _start % 60;
        if (tempRemain != remainTimeMin && remainTimeSec != 0) {
          remainTimeMin = tempRemain;
        }
        notifyListeners();
      }
    });
  }

  Future<void> getExamData(String id) async {
    exam = null;
    questions = [];
    answerList = [];
    try {
      print("1");
      exam = await ExamService().getExam(id);
      print("2");
      List<String> questionIdList = exam.questions.cast<String>();
      for (String questionId in questionIdList) {
        List<Answer> answers = [];
        Question question = await ExamService().getQuestion(questionId);
        print("3");
        List<String> answerIdList = question.answers.cast<String>();
        print("4");
        for (String answerId in answerIdList) {
          print("5");
          Answer answer = await ExamService().getAnswer(answerId);
          print("6");
          answers.add(answer);
        }
        questions.add({question: answers});
        answerList.add(null);
      }
    } catch (e) {
      print("DEBUG: Error getExamData $e");
    }
  }
}
