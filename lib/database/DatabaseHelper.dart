import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corner_ar_gp/Category/Category.dart';
import 'package:corner_ar_gp/Furniture/Furniture.dart';
import 'package:corner_ar_gp/person/Person.dart';
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

CollectionReference<Person> getPersonCollectionWithConverter(String collectionName){
  return FirebaseFirestore.instance.collection(collectionName).withConverter<Person>(
    fromFirestore: (snapshot, _) => Person.fromJson(snapshot.data()!),
    toFirestore: (person, _) => person.toJson(),
  );
}

CollectionReference<Category> getCategoryCollectionWithConverter(String collectionName){
  return FirebaseFirestore.instance.collection(collectionName).withConverter<Category>(
    fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()!),
    toFirestore: (category, _) => category.toJson(),
  );
}

CollectionReference<Furniture> getFurnitureCollectionWithConverter(String collectionName){
  return FirebaseFirestore.instance.collection(collectionName).withConverter<Furniture>(
    fromFirestore: (snapshot, _) => Furniture.fromJson(snapshot.data()!),
    toFirestore: (furniture, _) => furniture.toJson(),
  );
}