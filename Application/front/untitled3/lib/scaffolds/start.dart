import 'package:flutter/material.dart';
import 'package:untitled3/scaffolds/signup.dart';

class Start extends StatelessWidget{
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    // TODO: implement build
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child:
          Stack(
            children: [
              Container(
                height: height * 0.8,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: AssetImage("asset/4612177.jpg"),
                        //image: NetworkImage("https://www.hospitalitynet.org/picture/153129474.jpg?t=1626196020"),
                        fit: BoxFit.fill

                    )
                ),
              ),
              // SizedBox(height: 10,),
              Padding(
                padding:  EdgeInsets.only(top: height*0.6),
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white
                  ),
                  child: Column(

                    children: [
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: 20.0),
                                child: Text("Fake news detection!", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 30),textAlign: TextAlign.center,),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: 20.0),
                                child: Text("Fake news can cause harm in a variety of ways , this App detects if the tweet is real or fake ",
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black38,fontSize: 20),
                                  textAlign: TextAlign.center,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height*0.05,left: 20, right: 20),
                        child: Container(
                          height: 60,
                          //width: 240,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
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
                                    Color(0xFFE0F2F1),
                                    Color(0xFFB2DFDB),
                                    //     Color(0xFF4DB6AC),

                                  ]
                              )),
                          child: Center(
                            child: GestureDetector(

                              child: Text("Get Started",style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                              },
                            ),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}