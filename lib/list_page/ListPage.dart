import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../database/DatabaseHelper.dart';
import '../person/Admin.dart';

class ListPage extends StatefulWidget {
  static const routeName = 'listpage';

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String title = "Admins List";
  String collectionName=Admin.CollectionName;
  final _fireStore = FirebaseFirestore.instance;
  var admins;

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _fireStore.collection(collectionName).get();;
    // Get data from docs and convert map to List
    admins = querySnapshot.docs.map((doc) => doc.data()).toList();
    //for a specific field
    //allData = querySnapshot.docs.map((doc) => doc.get("email")).toList();
    print(admins);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/backgroundBottom.png',
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
          ),
          Container(
            child: Image.asset(
              'assets/backgroundTop.png',
              fit: BoxFit.fill,
              //height: double.infinity,
              width: double.infinity,
            ),
          ),
          Column(
            children: [
              ElevatedButton(onPressed: ()=>getData(), child: Text("button"))
            ],
          )

        ],
      ),
    );
  }
}
