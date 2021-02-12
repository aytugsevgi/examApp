class Classroom {
  String _id;
  String _name;
  List<dynamic> _exams;
  Classroom({String id, String name, List<dynamic> exams}) {
    this._id = id;
    this._name = name;
    this._exams = exams;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  List<dynamic> get exams => _exams;
  set exams(List<dynamic> exams) => _exams = exams;

  Classroom.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _exams = json['exams'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['exams'] = this._exams;
    return data;
  }
}
