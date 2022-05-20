import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corner_ar_gp/authentication/registration/registration_screen.dart';
import 'package:corner_ar_gp/main_screens/add_category/AddCategoryPage.dart';
import 'package:corner_ar_gp/main_screens/add_furniture/add_furniture_screen.dart';
import 'package:corner_ar_gp/person/Admin.dart';
import 'package:flutter/material.dart';

import '../../components/dropDownList_components.dart';
import '../../components/getdata_components.dart';


class FurnitureListPage extends StatefulWidget {
  String title;
  String collectionName;
  var Data;
  var categoryData;
  var furnitureInCategory;
  int dataLength;
  FurnitureListPage({required this.title,required this.collectionName,
    required this.Data,required this.dataLength,required this.categoryData,required this.furnitureInCategory});
  @override
  _FunitureListPageState createState() =>
      _FunitureListPageState(this.title,this.collectionName,this.Data,this.dataLength,this.categoryData,this.furnitureInCategory);
}

class _FunitureListPageState extends State<FurnitureListPage> {
  String title;
  String collectionName;
  String buttonName="Add Admin";
  var data;
  var originalData;
  var categoryData;
  String categoryID = '';
  var furnitureInCategory;
  int dataLength;
  _FunitureListPageState(this.title,this.collectionName,this.data,this.dataLength,this.categoryData,this.furnitureInCategory){
    originalData = this.data;
  }

  String dropdownValue = "All";
  //originalData = data;

  List<String> convertDataToList(){
    List<String> list = [];
    list.add("All");
    for(int i=0;i<categoryData.length;i++){
      list.add(categoryData[i]['name']);
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
    for(int i=0;i<categoryData.length;i++){
      if(dropdownValue == "All") {
        setState(() {
          categoryID = '';
          data = originalData;
          dataLength = data.length;
        });
      }
      else if(categoryData[i]['name'] == dropdownValue){
        print("${categoryData[i]['name']} == $dropdownValue");
          setState(() {
            categoryID = categoryData[i]["id"];
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
                    return Container(
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
                                  child: Text(data[index]['modelName'],style: TextStyle(fontSize: 15),),
                                ),
                                Align(
                                    child: IconButton(
                                      onPressed: ()async{
                                        print(data[index]['id']);

                                        var newData;
                                        await FirebaseFirestore.instance.collection("Category")
                                            .doc(data[index]["categoryID"]).collection(collectionName).doc(data[index]['id'])
                                            .delete()
                                            .then((_) async {
                                          print('Deleted');

                                          newData = await getDataFurniture(collectionName);
                                          print(newData);
                                          print(newData.length);
                                          print("finsih");
                                          print(index);
                                          setState((){});
                                        }).catchError((error) => print('Delete failed: $error'));
                                        print("out");
                                        print(index);
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
                    );
                  }),
                ),
              ),
            ],
          ),
          // ListView.builder(
          //   itemCount: dataLength,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Container(
          //         padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
          //         child: Container(
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(15)
          //           ),
          //           child: Row(
          //             children: [
          //               Expanded(
          //                 child: Container(
          //                   child: Text(data[index]['modelName'],style: TextStyle(fontSize: 20),),
          //                   padding: const EdgeInsets.only(left: 10),
          //                 ),
          //               ),
          //               Align(
          //                 child: IconButton(
          //                   onPressed: ()async{
          //                     // print(data[index]['id']);
          //                     //
          //                     // await FirebaseFirestore.instance.collection(collectionName)
          //                     //     .doc(data[index]['id'])
          //                     //     .delete()
          //                     //     .then((_) async {
          //                     //   print('Deleted');
          //                     //   data = await getData(collectionName);
          //                     //   print(data);
          //                     //   print(data.length);
          //                     //   print("finsih");
          //                     //   print(index);
          //                     //   setState((){});
          //                     // }).catchError((error) => print('Delete failed: $error'));
          //                     // print("out");
          //                     // print(index);
          //                     // setState((){
          //                     //   dataLength = data.length;
          //                     // });
          //
          //                   },
          //                   icon: const ImageIcon(
          //                     AssetImage("assets/remove.png"),
          //                     color: Colors.red,
          //                   ),
          //                 ),
          //                 alignment: Alignment.centerLeft,
          //               )
          //
          //             ],
          //           ),
          //         )
          //     );
          //   },
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: categoryID== ''? null
            :(){
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