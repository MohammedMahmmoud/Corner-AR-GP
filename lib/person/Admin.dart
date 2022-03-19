class Admin{
  String id;
  String adminName;
  String email;
  static const String CollectionName = 'Admin';
  Admin({required this.email,required this.id,required this.adminName});
  Admin.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    adminName: json['adminName']! as String,
    email: json['email']! as String,
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'adminName': adminName,
      'email' : email,
    };
  }
}