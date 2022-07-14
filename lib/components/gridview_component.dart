import 'package:flutter/material.dart';


GridView gridview_furnitureList(
{
  required int dataLength,
  required var data,
  required Function onPressed,
  required var icon,
  Function? spwan,
  BuildContext? context,
  required bool isSpwaned
}
    ){
  return GridView.count(
    crossAxisCount: 2,
    padding: EdgeInsets.only(left: 5),
    children: List.generate(dataLength, (index) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ElevatedButton(
          onPressed: (){
            if(isSpwaned){
              spwan!(data[index]['modelUrl']);
            }
          },
          style:ElevatedButton.styleFrom(
            primary: Colors.white,
            //onPrimary: Colors.transparent,
          ),
          child: Container(
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
                        child: IconButton(
                          onPressed: (){
                            onPressed(index);
                          },
                          icon: icon
                        ),
                        alignment: Alignment.centerLeft,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }),
  );
}