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

Future<List> getDataFurniture(collectionName,parentCollectionName) async{
  final _fireStore = FirebaseFirestore.instance;
  var dataParent = await getData(parentCollectionName);
  var dataFurniture;
  var dataFurnitureTemp;
  List parentFurniture = [];
  QuerySnapshot querySnapshot;
  for(int i=0;i<dataParent.length;i++){
    querySnapshot = await _fireStore.collection(parentCollectionName).doc(dataParent[i]['id']).collection(collectionName).get();
    dataFurnitureTemp = await querySnapshot.docs.map((doc) => doc.data()).toList();
    parentFurniture.add(dataFurnitureTemp);
    if(i==0)
      dataFurniture = dataFurnitureTemp;
    else
      dataFurniture += dataFurnitureTemp;
  }
  print(dataFurniture);
  print("innnnaddddmin paaage daaaata");
  return [dataFurniture,parentFurniture];
}
//
// Future<dynamic> getCategoryFurniture(collectionName, int id) async{
//   final _fireStore = FirebaseFirestore.instance;
//   var dataCategory = await getData("Category");
//   var dataFurniture;
//   QuerySnapshot querySnapshot = await _fireStore.collection("Category").doc(dataCategory[id]['id']).collection(collectionName).get();
//   dataFurniture = await querySnapshot.docs.map((doc) => doc.data()).toList();
//   print(dataFurniture);
//   print("innnnaddddmin paaage daaaata");
//   return dataFurniture;
// }