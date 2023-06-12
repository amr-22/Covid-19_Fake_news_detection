import 'package:flutter/material.dart';
import 'package:untitled3/scaffolds/getstart.dart';
import 'package:untitled3/scaffolds/homee.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Gettart() ,
    );
  }
}
