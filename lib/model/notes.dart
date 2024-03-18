class NotesModel {
  int? _id;
  late final String _title;
  late final int _age;
  late final String _description;
  late final String _email;

  // default constructor
  NotesModel();

  // named constructor for convert map object into model object
  NotesModel.fromMap(Map<String, dynamic> res)
      : _id = res['id'],
        _title = res['title'],
        _age = res['age'],
        _description = res['description'],
        _email = res['email'];

  // convert model object into map object

  Map<String, Object?> toMap() {
    return {
      'id': _id,
      'title': _title,
      'age': _age,
      'description': _description,
      'email': _email
    };
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  String get title => _title;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  set title(String value) {
    _title = value;
  }
}
