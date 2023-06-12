// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Button extends StatefulWidget {
//   dynamic text;
//   final VoidCallback ontap;
//
//   Button(this.text, this.ontap);
//
//   @override
//   State<Button> createState() => _ButtonState();
// }
//
// class _ButtonState extends State<Button> {
//    bool _isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       width: 250,
//
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100.0),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0x80000000),
//               blurRadius: 12.0,
//               offset: Offset(0.0, 5.0),
//             ),
//           ],
//           gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.indigo,
//                 Colors.lightBlueAccent,
//
//               ]
//           )),
//         child:ElevatedButton(
//           onPressed: () {
//             CircularProgressIndicator()
//             setState(() {
//               _isLoading = true;
//             });
//             // Perform some asynchronous operation
//             Future.delayed(Duration(seconds: 2), () {
//               setState(() {
//                 _isLoading = false;
//               });
//             });
//           },
//           child: _isLoading
//               ? CircularProgressIndicator()
//               : Text('Submit'),
//         )
//
//
//
//       // Center(
//       //   child: GestureDetector(
//       //     child:text,
//       //     onTap:ontap,
//       //   ),
//       //
//       // ),
//     );
//   }
// }
