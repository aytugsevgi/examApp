class Exam {
  String _id;
  String _title;
  String _createdDate;
  String _dueDate;
  List<dynamic> _questions;

  Exam(
      {String id,
      String title,
      String createdDate,
      String dueDate,
      List<dynamic> questions}) {
    this._id = id;
    this._title = title;
    this._createdDate = createdDate;
    this._dueDate = dueDate;
    this._questions = questions;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;
  String get createdDate => _createdDate;
  set createdDate(String createdDate) => _createdDate = createdDate;
  String get dueDate => _dueDate;
  set dueDate(String dueDate) => _dueDate = dueDate;
  List<dynamic> get questions => _questions;
  set questions(List<dynamic> questions) => _questions = questions;

  Exam.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _createdDate = json['createdDate'];
    _dueDate = json['dueDate'];
    _questions = json['questions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['createdDate'] = this._createdDate;
    data['dueDate'] = this._dueDate;
    data['questions'] = this._questions;
    return data;
  }
}
