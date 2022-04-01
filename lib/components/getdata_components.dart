import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> getData(collectionName) async{
  final _fireStore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await _fireStore.collection(collectionName).get();
  //querySnapshot.docs
  // Get data from docs and convert map to List
  var Data = await querySnapshot.docs.map((doc) => doc.data()).toList();
  print("innnnaddddmin paaage daaaata");
  return Data;
}