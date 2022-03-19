import 'package:corner_ar_gp/person/Person.dart';

class User extends Person{

  static const String CollectionName = 'User';
  User(): super();

  //read from db
  User.fromJson(Map<String, Object?> json)
      : super(
    id: json['id']! as String,
    name: json['userName']! as String,
    email: json['email']! as String,
  );

  //to write in db
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'userName': name,
      'email' : email,
    };
  }
}