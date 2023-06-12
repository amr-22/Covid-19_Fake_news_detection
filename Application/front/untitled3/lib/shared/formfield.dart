
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormFields extends StatelessWidget {
  TextEditingController textFieldController = TextEditingController();
  dynamic prefix;
  dynamic suffix;
  dynamic fillcolor;
  String x = "";

  dynamic color;
  bool IsObsecure;
  FormFields(this.x,this.prefix,this.suffix,this.IsObsecure,this.textFieldController, this.fillcolor, this.color);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: TextStyle(height:1.8, color: Colors.black54, fontFamily: 'sign',),
        validator: (String? text){
          if(textFieldController.text == ''){
            return 'This Field is Required.';
          }
        },
        obscureText: IsObsecure,
        cursorColor: Colors.indigo,
        controller: textFieldController,
        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffix,
          filled: true,
          fillColor: fillcolor,
          floatingLabelStyle: TextStyle(color:Colors.indigo),
          labelStyle: TextStyle(color: Colors.indigo),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.indigo,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:Colors.indigo, width:3),
          ),
          labelText: x,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
            //borderSide: BorderSide(color: Colors.white, width: 3)
          ),
        ));
  }
}