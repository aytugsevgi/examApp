class Answer {
  String _id;
  String _content;
  bool _isCorrect;

  Answer({String id, String content, bool isCorrect}) {
    this._id = id;
    this._content = content;
    this._isCorrect = isCorrect;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get content => _content;
  set content(String content) => _content = content;
  bool get isCorrect => _isCorrect;
  set isCorrect(bool isCorrect) => _isCorrect = isCorrect;

  Answer.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _content = json['content'];
    _isCorrect = json['isCorrect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['content'] = this._content;
    data['isCorrect'] = this._isCorrect;
    return data;
  }
}
