import 'package:cloud_firestore/cloud_firestore.dart';
import '../person/Admin.dart';
import '../person/User.dart';


//to manibulate specific collection
CollectionReference<User> getUsersCollectionWithConverter(){
  return FirebaseFirestore.instance.collection(User.CollectionName).withConverter<User>(
    fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );
}


CollectionReference<Admin> getAdminsCollectionWithConverter(){
  return FirebaseFirestore.instance.collection(Admin.CollectionName).withConverter<Admin>(
    fromFirestore: (snapshot, _) => Admin.fromJson(snapshot.data()!),
    toFirestore: (admin, _) => admin.toJson(),
  );
}