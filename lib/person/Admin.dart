import 'package:corner_ar_gp/person/Person.dart';

class Admin extends Person{

  static const String CollectionName = 'Admin';
  Admin(): super();

  Admin.fromJson(Map<String, Object?> json)
      : super(
    id: json['id']! as String,
    name: json['adminName']! as String,
    email: json['email']! as String,
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'adminName': name,
      'email' : email,
    };
  }
}