import 'package:acb_admin/HomePage.dart';
import 'package:acb_admin/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBn6lXK0B-txFUrj13ICLREZkznK08LF2E",
      projectId: "ac-baradise-1969",
      messagingSenderId: "813682247245",
      appId: "1:813682247245:web:f4d0b1e689ce33c82f7e04",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key})
      : super(key: key); // Use Key? key and correct super syntax

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MyHomePage(),
      );
}
