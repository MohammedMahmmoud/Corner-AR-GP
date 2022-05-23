import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

CollectionReference<Furniture> getFurnitureCollectionWithConverter({String collectionName = Furniture.collectionName}){
  return FirebaseFirestore.instance.collection(collectionName).withConverter<Furniture>(
    fromFirestore: (snapshot, _) => Furniture.fromJson(snapshot.data()!),
    toFirestore: (furniture, _) => furniture.toJson(),
  );
}


Future<bool> uploadModel(String categoryId, Furniture furniture, File modelBytes, File pictureBytes) async{
  bool isSuccessful = true;
  furniture.setCategory(categoryId);

  final furnitureDoc = FirebaseFirestore.instance
      .collection(Category.collectionName)
      .doc(categoryId)
      .collection(Furniture.collectionName)
      .doc();

  print("here the id :             ${furnitureDoc.id}");
  furniture.setId(furnitureDoc.id);
  Set<String> modelDetailsURLs = await uploadToStorage(furnitureDoc.id, modelBytes, pictureBytes);


  print("here the model url :             ${modelDetailsURLs.first}");
  print("here the model picture url :             ${modelDetailsURLs.last}");

  furniture.setModelUrl(modelDetailsURLs.first);
  furniture.setImageUrl(modelDetailsURLs.last);

  await furnitureDoc
      .set(furniture.toJson()).onError((e, _){print("Error writing document: $e"); isSuccessful = false;});

  print("added to fireStore");

  return isSuccessful;
}

Future<Set<String>> uploadToStorage(String modelId, File modelBytes, File pictureBytes) async {
  final storageRef = FirebaseStorage.instance.ref();
  final modelRef = storageRef.child(modelId);
  final modelBytesRef = modelRef.child("/model");
  final modelPictureRef = modelRef.child("/picture");


  print("model-=-=-=-=-====> $modelBytes");
  await modelBytesRef.putFile(modelBytes);
  print('puted ++++++++++++++++++++++++++');
  //     .snapshotEvents.listen((taskSnapshot) {
  //     .snapshotEvents.listen((taskSnapshot) {
  //   switch (taskSnapshot.state) {
  //     case TaskState.running:
  //     // ...
  //       break;
  //     case TaskState.paused:
  //     // ...
  //       break;
  //     case TaskState.success:
  //     // ...
  //       break;
  //     case TaskState.canceled:
  //     // ...
  //       break;
  //     case TaskState.error:
  //     // ...
  //       break;
  //   }
  // });
  print('image -=-=-=-=-=-=-=-=-===> $pictureBytes');
  await modelPictureRef.putFile(pictureBytes);
  print("puten +++++++++++++++++++++++++++++");
  //     .snapshotEvents.listen((taskSnapshot) {
  //   switch (taskSnapshot.state) {
  //     case TaskState.running:
  //     // ...
  //       break;
  //     case TaskState.paused:
  //     // ...
  //       break;
  //     case TaskState.success:
  //     // ...
  //       break;
  //     case TaskState.canceled:
  //     // ...
  //       break;
  //     case TaskState.error:
  //     // ...
  //       break;
  //   }
  // });

  String modelUrl = await modelBytesRef.getDownloadURL(), pictureUrl = await modelPictureRef.getDownloadURL();

  return {modelUrl, pictureUrl};
}

//
// Future<bool> saveFurniture(String UserId, Furniture furniture, File modelBytes, File pictureBytes) async{
//   bool isSuccessful = true;
//   furniture.setCategory(UserId);
//
//   final furnitureDoc = FirebaseFirestore.instance
//       .collection(Category.collectionName)
//       .doc(UserId)
//       .collection(Furniture.collectionName)
//       .doc();
//
//   print("here the id :             ${furnitureDoc.id}");
//   furniture.setId(furnitureDoc.id);
//   furniture.setModelUrl(furniture.getModelUrl());
//   furniture.setImageUrl(furniture.getModelUrl());
//
//   await furnitureDoc.set(furniture.toJson()).onError((e, _){print("Error writing document: $e"); isSuccessful = false;});
//
//   print("added to fireStore");
//
//   return isSuccessful;
// }