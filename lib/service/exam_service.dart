import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/model/answer.dart';
import 'package:examapp/model/classroom.dart';
import 'package:examapp/model/current_user.dart';
import 'package:examapp/model/exam.dart';
import 'package:examapp/model/instructor.dart';
import 'package:examapp/model/question.dart';
import 'package:uuid/uuid.dart';

class ExamService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createExam(
      String name,
      DateTime startDate,
      DateTime dueDate,
      List<Map<String, List<Map<String, bool>>>> questions,
      Classroom classroom) async {
    try {
      List<String> questionIdList = await _saveQuestions(questions);
      var uuid = Uuid();
      String examId = uuid.v1();
      Exam exam = Exam(
          id: examId,
          title: name,
          startDate: startDate,
          dueDate: dueDate,
          questions: questionIdList);
      print("BAŞLADI");
      await _firestore.collection("exams").doc(examId).set(exam.toJson());
      print("BİTTİ");
      return examId;
    } catch (e) {
      print("DEBUG: Error ExamService createExam $e");
      return null;
    }
  }

  Future<Exam> getExam(String id) async {
    try {
      var map = await _firestore.collection("exams").doc(id).get();
      return Exam.fromJson(map.data());
    } catch (e) {
      print("DEBUG: Error ExamService getExam $e");
      return null;
    }
  }

  Future<Question> getQuestion(String id) async {
    try {
      var map = await _firestore.collection("questions").doc(id).get();
      return Question.fromJson(map.data());
    } catch (e) {
      print("DEBUG: Error ExamService getQuestion $e");
      return null;
    }
  }

  Future<Answer> getAnswer(String id) async {
    try {
      var map = await _firestore.collection("answers").doc(id).get();
      return Answer.fromJson(map.data());
    } catch (e) {
      print("DEBUG: Error ExamService getAnswer $e");
      return null;
    }
  }

  Future<List<String>> _saveQuestions(
      List<Map<String, List<Map<String, bool>>>> questions) async {
    List<String> questionIdList = [];
    var uuid = Uuid();
    try {
      for (var question in questions) {
        List<String> answerIdList = [];

        for (var answer in question.values.first) {
          String id = uuid.v1();
          await _firestore.collection("answers").doc(id).set({
            "id": id,
            "content": answer.keys.first,
            "isCorrect": answer.values.first
          });
          answerIdList.add(id);
        }

        String id = uuid.v1();
        await _firestore.collection("questions").doc(id).set(
            {"id": id, "title": question.keys.first, "answers": answerIdList});

        questionIdList.add(id);
      }
      return questionIdList;
    } catch (e) {
      print("DEBUG: examService saveQuestion error $e");
    }
  }
}
