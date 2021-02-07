class Student {
  String _userId;
  String _firstName;
  String _lastName;
  String _email;

  Student({String userId, String firstName, String lastName, String email}) {
    this._userId = userId;
    this._firstName = firstName;
    this._lastName = lastName;
    this._email = email;
  }

  String get userId => _userId;
  set userId(String userId) => _userId = userId;
  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;
  String get lastName => _lastName;
  set lastName(String lastName) => _lastName = lastName;
  String get email => _email;
  set email(String email) => _email = email;

  Student.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this._userId;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['email'] = this._email;
    return data;
  }
}
