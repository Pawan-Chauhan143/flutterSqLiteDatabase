class NotesModel {
  late final int? id;
  late final String title;
  late final int age;
  late final String description;
  late final String email;

  // constructor
  NotesModel({this.id,
    required this.title,
    required this.age,
    required this.description,
    required this.email});

  // named constructor for convert map object into model object
  NotesModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        age = res['age'],
        description = res['description'],
        email = res['email'];


  // convert model object into map object

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'age': age,
      'description': description,
      'email': email
    };
  }
}
