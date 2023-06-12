import 'package:flutter/cupertino.dart';

class PhotoCard extends StatelessWidget {
  dynamic image;
  PhotoCard(this.image);
  var width, height, size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      child:image,
      width: width*0.5,
      height: height*0.18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
