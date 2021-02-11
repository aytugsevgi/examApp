import 'package:examapp/model/answer.dart';

class Question {
  String _id;
  String _title;
  String _createdDate;
  List<dynamic> _answers;

  Question(
      {String id, String title, String createdDate, List<dynamic> answers}) {
    this._id = id;
    this._title = title;
    this._createdDate = createdDate;
    this._answers = answers;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;
  String get createdDate => _createdDate;
  set createdDate(String createdDate) => _createdDate = createdDate;
  List<dynamic> get answers => _answers;
  set answers(List<dynamic> answers) => _answers = answers;

  Question.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _createdDate = json['createdDate'];
    _answers = json['answers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['createdDate'] = this._createdDate;
    data['answers'] = this._answers;
    return data;
  }
}
