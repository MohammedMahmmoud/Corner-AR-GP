import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corner_ar_gp/main_screens/add_furniture/add_furniture_screen.dart';
import 'package:corner_ar_gp/person/Admin.dart';
import 'package:flutter/material.dart';

import '../../Furniture/Furniture.dart';
import '../../components/dropDownList_components.dart';
import '../../components/getdata_components.dart';
import '../../database/DatabaseHelper.dart';


class FurnitureListPage extends StatefulWidget {
  String title;
  String collectionName;
  var Data;
  var parentData;
  var furnitureInCategory;
  int dataLength;
  bool isViewing;
  String parentCollection;
  String parentID;
  FurnitureListPage({required this.title,required this.collectionName,
    required this.Data,required this.dataLength,
    required this.parentData,required this.furnitureInCategory,required this.isViewing,
    required this.parentCollection,required this.parentID});
  @override
  _FunitureListPageState createState() =>
      _FunitureListPageState(this.title,this.collectionName,this.Data,this.dataLength,
          this.parentData,this.furnitureInCategory,this.isViewing,parentCollection,parentID);
}

class _FunitureListPageState extends State<FurnitureListPage> {
  String title;
  String collectionName;
  String buttonName="Add Admin";
  var data;
  var originalData;
  var parentData;
  String categoryID = '';
  var furnitureInCategory;
  int dataLength;
  bool isViewing;
  String parentCollection;
  String parentID;
  _FunitureListPageState(this.title,this.collectionName,this.data,
      this.dataLength,this.parentData,this.furnitureInCategory,this.isViewing,this.parentCollection,this.parentID){
    originalData = this.data;
  }

  String dropdownValue = "All";
  //originalData = data;

  List<String> convertDataToList(){
    List<String> list = [];
    list.add("All");
    for(int i=0;i<parentData.length;i++){
      list.add(parentData[i]['name']);
    }
    return list;
  }

  @override
  void initState() {
    print(dataLength);
    setState(() {});
    super.initState();
  }


  void changeDropListValue(String? newValue)  {
    dropdownValue = newValue!;
    for(int i=0;i<parentData.length;i++){
      if(dropdownValue == "All") {
        setState(() {
          categoryID = '';
          data = originalData;
          dataLength = data.length;
        });
      }
      else if(parentData[i]['name'] == dropdownValue){
        print("${parentData[i]['name']} == $dropdownValue");
          setState(() {
            categoryID = parentData[i]["id"];
            data = furnitureInCategory[i];
            dataLength = furnitureInCategory[i].length;
          });
          break;
      }else{
        setState(() {
          data = [];
          dataLength = 0;
        });
      }
    }
    setState(() {});
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: categoryDropDownList(
                  dropdownValue: dropdownValue,
                  onPressedButton: (String? newValue) => changeDropListValue(newValue),
                  categoryList: convertDataToList(),
                )
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  //padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                  children: List.generate(dataLength, (index) {
                    return ElevatedButton(
                      onPressed: () {  },
                      style:ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(0, 0, 0, 0),
                        onPrimary: Colors.white,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Image(
                                image: NetworkImage(data[index]['imageUrl']),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(data[index]['modelName'],style: TextStyle(fontSize: 15,color: Colors.blueGrey),),
                                  ),
                                  Align(
                                      child: isViewing? IconButton(
                                        onPressed: ()async{
                                          print(parentID);
                                          print(data[index]['modelName']);
                                          Furniture furniture = Furniture(
                                            parentID: parentID,
                                            id: data[index]['id'],
                                            imageUrl: data[index]['imageUrl'],
                                            modelName: data[index]['modelName'],
                                            modelUrl: data[index]['modelUrl']
                                          );
                                          await saveFurniture(furniture).then((value) => print("heeeeellllllllllllllllll"));
                                        },
                                        icon: const Icon(
                                          Icons.save,
                                          color: Colors.blueGrey,
                                          //size: 30.0,
                                        ),
                                      )
                                          :IconButton(
                                        onPressed: ()async{
                                          var newData;

                                          await FirebaseFirestore.instance.collection(parentCollection)
                                              .doc(data[index]["parentID"]).collection(collectionName).doc(data[index]['id'])
                                              .delete()
                                              .then((_) async {
                                            newData = await getDataFurniture(collectionName,parentCollection);
                                            print(newData);
                                            setState((){});
                                            print("-------------------------------------------------------");
                                          }).catchError((error) => print('Delete failed: $error'));
                                          setState((){
                                            data = newData[0];
                                            furnitureInCategory = newData[1];
                                            dataLength = data.length;
                                          });

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
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: categoryID== ''? null :
      FloatingActionButton(
        onPressed: (){
          if(true || collectionName == Admin.CollectionName){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>AddFurnitureScreen(categoryID: categoryID),)
            );
          }
        }

        ,child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}