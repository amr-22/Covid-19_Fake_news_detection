import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../shared/button.dart';
import '../shared/photocard.dart';
import 'getstart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
  TextEditingController inputData = new TextEditingController();
  String prediction="";
  final currentUser = FirebaseAuth.instance;
  String currentID = FirebaseAuth.instance.currentUser!.uid;
}
class _HomeState extends State<Home> {
  var width, size, height;
  dynamic input='';

  // Future<void> makePostRequest() async {
  //   print("-------");
  //   print(input);
  //   print(widget.inputData.text);
  //   print("-------");
  //   // final url = Uri.parse('http://172.30.16.1:5000/predict');
  //   final url = Uri.parse('http://127.0.0.1:5000/predict');
  //
  //   print("-------");
  //   var headers = {'Content-Type': 'application/json'};
  //   print(headers);
  //   final body = jsonEncode({'input': input});
  //   print(body);
  //
  //   // var response = await http.post(url, headers: headers, body: body);
  //   try{
  //     await http.head(url);
  //   }on Exception catch(e){
  //     print("222");
  //     print(e);
  //   }
  //   catch(e){
  //     print("not work");
  //   }
  //
  //   var response = await http.head(url);
  //
  //   print("----r---");
  //
  //   if (response.statusCode == 200) {
  //     print('POST request successful');
  //   } else {
  //     print('POST request failed with status: ${response.statusCode}');
  //   }
  // }


  void _checkNews() async {
    print("...................1.......................");
    print(widget.inputData.text);
    final apiUrl = 'http://192.168.43.245:5000/predict';
    String _prediction=" ";
    // Make a POST request to the Flask API
    Uri.parse(apiUrl);
    print("...................1.......................");
    print(apiUrl);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers:{'Content-Type': 'application/json'},
      body: json.encode({'input': input}),
    );
    print('.................2...............');
    // Parse the JSON response and update the state
    setState(() {
      dynamic data = json.decode(response.body);
      print(data);
      _prediction = data['predictions'][0].toString();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Your tweet is $_prediction'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    });
  }

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
        appBar: AppBar(
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                  ),
                  child: Column(
                    children: [
                      SizedBox(width: 10,),
                      Padding(
                        padding: EdgeInsets.all(0.8),
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Image.asset("asset/user.png",fit: BoxFit.fill,),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top:10),
                        child:  FutureBuilder(
                            future: FirebaseFirestore.instance.collection('checker').doc(widget.currentID).get(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData == false) {
                                return Text('No Data');
                              }
                              return Text(snapshot.data['name'],style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,

                              ),);
                            }
                        ),

                      ),
                    ],
                  )
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.indigo,),
                title: Text('LogOut', style: TextStyle(color: Colors.indigo, fontSize: 25),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Gettart()));
                  // Your code here
                },
              ),

            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: height*0.01, left: width*0.05 ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: 10,),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Image.asset("asset/avatar (1).png",fit: BoxFit.fill,),
                      ),
                    ),
                    SizedBox(width: 30,),
                    Padding(padding: EdgeInsets.all(0.8),
                      child: FutureBuilder(
                          future: FirebaseFirestore.instance.collection('checker').doc(widget.currentID).get(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData == false) {
                              return Text('No Data');
                            }
                            return Container(
                              child:  Text("Hello, ${snapshot.data['name']}",style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                color: Colors.lightBlue,
                              ),),
                            );
                          }
                      ),)
                  ],
                ),
              ),
              Padding(
                  padding:  EdgeInsets.only(top: height*0.13),
                  child: PhotoCard(Image.asset("asset/n4.jpg", fit: BoxFit.fill,))
              ),
              Padding(
                  padding:  EdgeInsets.only(top: height*0.13, left: width*0.6),
                  child: PhotoCard(Image.asset("asset/n1.jpg", fit: BoxFit.fill,))
              ), Padding(
                  padding:  EdgeInsets.only(top: height*0.65),
                  child:PhotoCard(Image.asset("asset/n2.jpg", fit: BoxFit.fill,))
              ), Padding(
                  padding:  EdgeInsets.only(top: height*0.65, left: width*0.6),
                  child: PhotoCard(Image.asset("asset/n3.jpg", fit: BoxFit.fill,))
              ),
              Padding(
                padding:  EdgeInsets.only(top: height*0.38, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: widget.inputData,
                        decoration: InputDecoration(
                          //   border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.lightBlueAccent,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "Paste the tweet Here ...",
                            hintStyle: TextStyle(
                              color: Colors.black54,

                            )
                        ),

                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top:height*0.05),
                      child: Center(
                        child: Button(Text("Check..", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                                () {

                              if (widget.inputData.text == "" ||
                                  widget.inputData.text == " ") {
                                setState(() {

                                });
                                Fluttertoast.showToast(
                                  msg: "The field is empty!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.indigo[600],
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                              else {
                                input=widget.inputData.text;
                                // makePostRequest();
                                _checkNews();
                                // print(widget.inputData.text);
                                widget.inputData.text = " ";
                              }
                            }),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}