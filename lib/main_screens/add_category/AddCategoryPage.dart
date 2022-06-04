import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corner_ar_gp/Category/Category.dart';
import 'package:flutter/material.dart';

import '../../components/buttons_components.dart';
import '../../components/textField_components.dart';

class AddCategoryPage extends StatefulWidget {
  String title;
  AddCategoryPage(this.title);
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState(title);
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final validator = GlobalKey<FormState>();
  String title;
  Category category = Category();
  _AddCategoryPageState(this.title);
  bool isLoading = false;

  void setIsLoading(value){
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.blueGrey,
        ),
        body: Stack(children: [
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
          Container(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 12),
            child: Form(
              key: validator,
              child: textFormFieldComponent(
                hintText: "Category name",
                isPasswordTextForm: false,
                validator: category.categroyValidator,
                onChangedText: category.setName
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(70,180,70,0),
              child: LogAndRegisterButton(
                  buttonText: "Add Category",
                  onPressedButton:  ()=>category.addCategory(context, validator, (value)=>setIsLoading(value))
              )
          ),
          if (isLoading) const Center(
            child: CircularProgressIndicator(color: Colors.white, backgroundColor: Colors.blueGrey,),
          ),
        ])
    );
  }
}
