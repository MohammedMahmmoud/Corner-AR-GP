import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corner_ar_gp/authentication/registration/registration_screen.dart';
import 'package:corner_ar_gp/main_screens/add_category/AddCategoryPage.dart';
import 'package:corner_ar_gp/person/Admin.dart';
import 'package:flutter/material.dart';

import '../../components/getdata_components.dart';
import '../../database/DatabaseHelper.dart';


class ListPage extends StatefulWidget {
  static const routeName = 'listpage';
  String title;
  String collectionName;
  var Data;
  int dataLength;
  ListPage({required this.title,required this.collectionName,required this.Data,required this.dataLength});
  @override
  _ListPageState createState() => _ListPageState(this.title,this.collectionName,this.Data,this.dataLength);
}

class _ListPageState extends State<ListPage> {
  String title;
  String collectionName;
  String buttonName="Add Admin";
  var data;
  int dataLength;
  _ListPageState(this.title,this.collectionName,this.data,this.dataLength);
  bool isLoading = false;

  final _fireStore = FirebaseFirestore.instance;
  late QuerySnapshot querySnapshot;

  void setIsLoading(value){
    setState(() {
      isLoading = value;
    });
  }


  @override
  void initState() {
    print(dataLength);
    setState(() {});
    super.initState();
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
          ListView.builder(
            itemCount: dataLength,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            child: Text(data[index]['name'],style: TextStyle(fontSize: 20),),
                          padding: const EdgeInsets.only(left: 10),
                        ),
                      ),
                      Align(
                        child: IconButton(
                          onPressed: ()async{
                            setIsLoading(true);
                            print(data[index]['id']);

                            if(collectionName == "Category"){
                              deleteAllCategroyFurniture(data[index]['id']);
                            }
                            await FirebaseFirestore.instance.collection(collectionName)
                                .doc(data[index]['id'])
                                .delete()
                                .then((_) async {
                                  print('Deleted');
                                  data = await getData(collectionName);
                                  print(data);
                                  print(data.length);
                                  print("finsih");
                                  print(index);
                                  setState((){});
                                }).catchError((error) => print('Delete failed: $error'));
                            print("out");
                            print(index);
                            setState((){
                              dataLength = data.length;
                            });
                            setIsLoading(false);
                          },
                          icon: const ImageIcon(
                            AssetImage("assets/remove.png"),
                            color: Colors.red,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      )

                    ],
                  ),
                )
              );
            },
          ),
          if (isLoading) const Center(
            child: CircularProgressIndicator(color: Colors.white, backgroundColor: Colors.blueGrey,),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(collectionName == Admin.CollectionName){
            Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>RegistrationScreen(isAdmin: true),));
          }else{
            Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>AddCategoryPage("Add Category"),));

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (BuildContext context) =>AddCategoryPage("Add Category"),),
            // );
          }
        }

        ,child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}