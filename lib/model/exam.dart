import 'package:cloud_firestore/cloud_firestore.dart';

class Exam {
  String _id;
  String _title;
  DateTime _startDate;
  DateTime _dueDate;
  List<dynamic> _questions;
  bool isSubmitted;
  Exam(
      {String id,
      String title,
      DateTime startDate,
      DateTime dueDate,
      List<dynamic> questions}) {
    this._id = id;
    this._title = title;
    this._startDate = startDate;
    this._dueDate = dueDate;
    this._questions = questions;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;
  DateTime get startDate => _startDate;
  set startDate(DateTime startDate) => _startDate = startDate;
  DateTime get dueDate => _dueDate;
  set dueDate(DateTime dueDate) => _dueDate = dueDate;
  List<dynamic> get questions => _questions;
  set questions(List<dynamic> questions) => _questions = questions;

  Exam.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    startDate = json['startDate'].toDate();
    _dueDate = json['dueDate'].toDate();
    _questions = json['questions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    print("DEBUG: EXAM 1");
    data['id'] = this._id;
    print("DEBUG: EXAM 2");
    data['title'] = this._title;
    print("DEBUG: EXAM 3");
    data['startDate'] = Timestamp.fromDate(this._startDate);
    print("DEBUG: EXAM 4");
    data['dueDate'] = Timestamp.fromDate(this._dueDate);
    print("DEBUG: EXAM 5");
    data['questions'] = this._questions;
    print("DEBUG: EXAM 6");
    return data;
  }
}
