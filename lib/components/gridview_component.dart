import 'package:flutter/material.dart';


GridView gridview_furnitureList(
{
  required int dataLength,
  required var data,
  required Function onPressed,
  required var icon
}
    ){
  return GridView.count(
    crossAxisCount: 2,
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
      );
    }),
  );
}