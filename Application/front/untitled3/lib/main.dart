import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'authentication/ttt.dart';

late AuthenticationMethods authenticationMethods;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  authenticationMethods = AuthenticationMethods();
  runApp( MyApp());
}
