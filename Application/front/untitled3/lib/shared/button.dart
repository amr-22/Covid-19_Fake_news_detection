import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
   dynamic text;
   final VoidCallback ontap;

   Button(this.text, this.ontap);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 250,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.indigo,
                Colors.lightBlueAccent,

              ]
          )),
      child: Center(
        child: GestureDetector(
          child:text,
          onTap:ontap,
        ),

      ),
    );
  }
}
