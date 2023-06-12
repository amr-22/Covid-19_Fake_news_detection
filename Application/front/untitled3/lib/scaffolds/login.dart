import 'package:flutter/material.dart';
import 'package:untitled3/scaffolds/homee.dart';
import 'package:untitled3/scaffolds/signup.dart';
import '../main.dart';
import '../shared/button.dart';
import '../shared/formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
   Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var size, height, width;
  bool _isLoading = false;

   TextEditingController? email = new TextEditingController();

   TextEditingController? password = new TextEditingController();

   bool passwordVisible = false;

   bool isSecure = true;

   final formKey = GlobalKey<FormState>();

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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: width,
                  height: height*0.35,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:EdgeInsets.only(top:height*0.05, bottom: 20, right: 150),
                        child: Text("Welcome back..", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40)),
                      ),
                      Padding(
                        padding:EdgeInsets.only( left: 10, right: 10),
                        child: Text("Our application is waiting for you to run more checks on your news. This will help you to follow real news and avoid getting distracted. ",style: TextStyle(color: Colors.white, fontSize: 25),textAlign: TextAlign.center,),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: height*0.25, right: 25, left: 25),
                  child: Container(
                    width: width,
                    height: height*0.45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child:  Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.only(top: height*0.07, left: width*0.1, right: width*0.1),
                              child: FormFields(
                                  "Email",
                                  Icon(
                                    Icons.email,
                                    color: Colors.indigo,
                                  ),
                                  null,
                                  false,
                                  email!,
                                  Colors.transparent,
                                  Colors.indigo),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: height*0.05,  left: width*0.1, right: width*0.1),
                              child: FormFields(
                                  "PassWord",
                                  IconButton(
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.lock_open
                                          : Icons.lock_outline,
                                      color: Colors.indigo,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isSecure = !isSecure;
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isSecure = !isSecure;
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  ),
                                  isSecure,
                                  password!,
                                  Colors.transparent,
                                  Colors.indigo),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top:height*0.05),

                              child: Button(_isLoading?CircularProgressIndicator():Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),), () async {
                                _isLoading = true;
                                setState(() {
                                });
                                String output=  await authenticationMethods.logInUser(
                                    email:email!.text,
                                    password: password!.text);
                                if (output == "success") {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                                }
                                else {
                                  _isLoading = false;
                                  //error
                                  Fluttertoast.showToast(
                                    msg: output.toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.indigo[600],
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

          Padding(
            padding:  EdgeInsets.only(top: height*0.75),
            child: Center(
              child: Text(
                "Don't have an account?",
                style: TextStyle(
                    color: Colors.indigo, fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: height*0.79),
            child: Center(
                child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> SignUp()));
                    },
                    child: Column(
                      children: [
                        Text(
                          'Sign up now!',
                          style:
                          TextStyle(color: Colors.indigo, fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))),
          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}