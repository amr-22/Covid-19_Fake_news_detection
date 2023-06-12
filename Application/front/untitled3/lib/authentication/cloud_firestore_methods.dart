import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadUserToDataBase(
      {required String name, required String pass, required String email}) async {
    await firebaseFirestore.collection('checker').doc(
        firebaseAuth.currentUser!.uid).set(
        {
          'name': name,
          'email': email,
          'password':pass,
        }
    );
  }}
