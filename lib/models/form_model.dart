class Valid {
  int id;
  String email;
  DateTime date;
  String password;


  Valid({this.email, this.date, this.password});
  Valid.withId({this.id, this.email, this.date, this.password});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = email;
    map['date'] = date.toIso8601String();
    map['priority'] = password;
    return map;
  }

  factory Valid.fromMap(Map<String, dynamic> map) {
    return Valid.withId(
      id: map['id'],
      email: map['title'],
      date: DateTime.parse(map['date']),
      password: map['priority'],
    );
  }
}
