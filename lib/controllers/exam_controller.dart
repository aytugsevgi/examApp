import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/controllers/base_controller.dart';
import 'package:examapp/controllers/classroom_controller.dart';
import 'package:examapp/controllers/home_controller.dart';
import 'package:examapp/model/answer.dart';
import 'package:examapp/model/exam.dart';
import 'package:examapp/model/question.dart';
import 'package:examapp/model/student.dart';
import 'package:examapp/routes/application.dart';
import 'package:examapp/service/exam_service.dart';
import 'package:examapp/service/user_service.dart';
import 'package:examapp/widget/fade_route.dart';
import 'package:examapp/widget/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class ExamController with ChangeNotifier {
  Exam exam;
  List<Map<Question, List<Answer>>> questions = [];
  List<String> answerList = [];
  int remainTimeMin = 0;
  int remainTimeSec = 0;
  Timer _timer;
  List<dynamic> submittedUserAnswers = [];

  int getSuccessRate() {
    int correctAnswerCount = 0;
    for (int i = 0; i < questions.length; i++) {
      List<Answer> answers = questions[i].values.first;
      for (Answer answer in answers) {
        if (answer.isCorrect == true) {
          if (answer.id == submittedUserAnswers[i]) {
            correctAnswerCount += 1;
          }
          break;
        }
      }
    }
    return (100 * correctAnswerCount / questions.length).ceil();
  }

  void setAnswer(int index, String id) {
    answerList[index] = id;
    notifyListeners();
  }

  Future<void> submitExam() async {
    await ExamService().submitExam(answerList, exam);
  }

  void startRemainTime(BuildContext context) {
    Duration duration = exam.dueDate.difference(DateTime.now());
    int _start = duration.inSeconds;
    remainTimeMin = (_start / 60).floor();
    remainTimeSec = _start % 60;
    int tempRemain;
    const oneDecimal = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneDecimal, (Timer timer) async {
      if (_start < 1) {
        remainTimeMin = 0;
        notifyListeners();
        _timer.cancel();
        Navigator.push(
            context, TransparentRoute(builder: (context) => LoadingView()));
        await submitExam();
        Navigator.pop(context);
        Navigator.pop(context);
        context.read<ClassroomController>().resetData();
        await Application.router.navigateTo(context, "/");
        html.window.location.reload();
      } else {
        _start -= 1;
        tempRemain = (_start / 60).floor();
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
      exam = await ExamService().getExam(id);

      List<String> questionIdList = exam.questions.cast<String>();
      for (String questionId in questionIdList) {
        List<Answer> answers = [];
        Question question = await ExamService().getQuestion(questionId);

        List<String> answerIdList = question.answers.cast<String>();

        for (String answerId in answerIdList) {
          Answer answer = await ExamService().getAnswer(answerId);

          answers.add(answer);
        }
        questions.add({question: answers});
        answerList.add(null);
      }
    } catch (e) {
      print("DEBUG: Error getExamData $e");
    }
  }

  Future<List<Student>> getExamParticipants(Exam e) async {
    try {
      print("0");
      List<QueryDocumentSnapshot> snapshots =
          await ExamService().getExamParticipants(e);
      print("1");
      print(snapshots);
      List<Student> students = [];
      for (QueryDocumentSnapshot snapshot in snapshots) {
        print("2");
        Student student = await UserService().searchUser(snapshot.id);
        students.add(student);
        print("3");
      }
      return students;
    } catch (e) {
      print("DEBUG: Error on ExamController getExamParticipants $e");
      return [];
    }
  }

  Future<void> getUserAnswers(String examId, String userId) async {
    try {
      submittedUserAnswers =
          await ExamService().submittedUserAnswers(examId, userId);
    } catch (e) {
      print("DEBUG: Error ExamController getCurrentUserAnswers $e");
    }
  }
}
