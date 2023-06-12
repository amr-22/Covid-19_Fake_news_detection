 import 'package:flutter/material.dart';
import 'package:untitled3/scaffolds/signup.dart';
import 'package:untitled3/shared/button.dart';

class Gettart extends StatelessWidget {
  Gettart({Key? key}) : super(key: key);
   var size, height, width;

   @override
   Widget build(BuildContext context) {
     size = MediaQuery.of(context).size;
     height = size.height;
     width = size.width;
     return WillPopScope(
       onWillPop: ()async{
         return false;
       },
       child: Scaffold(
         backgroundColor: Colors.white,
         body: SafeArea(
           child: SingleChildScrollView(
             child: Column(
               children: [
                 Padding(
                   padding:  EdgeInsets.only(top: height*0.1, bottom: 10),
                   child: Text("Fake news detection of", style: TextStyle(color: Colors.indigo, fontSize: 40, fontWeight: FontWeight.bold),),
                 ),
                 Text("COVID-19", style: TextStyle(color: Colors.lightBlueAccent.shade100, fontSize: 30, fontWeight: FontWeight.bold),),

                 Image.asset("asset/4620635.jpg"),
                 Text("Fake news is a virus that can infect the mind, but with the power of technology, we can vaccinate ourselves against its harmful effects",style: TextStyle(color: Colors.lightBlueAccent.shade100, fontSize: 20),textAlign: TextAlign.center,),
         Padding(
             padding:  EdgeInsets.only(top:height*0.07),

             child:Button(Text("Get Start..", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),), (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
             })
         ),
               ],
             ),
           ),
         ),
       ),
     );
   }
 }
 