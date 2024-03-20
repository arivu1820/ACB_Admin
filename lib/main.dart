import 'package:acb_admin/Authentication/auth_page.dart';
import 'package:acb_admin/HomePage.dart';
import 'package:acb_admin/Screens/GeneralProductsScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized

  await Firebase.initializeApp(
    options: const FirebaseOptions(
       apiKey: "AIzaSyBn6lXK0B-txFUrj13ICLREZkznK08LF2E",
      authDomain: "ac-baradise-1969.firebaseapp.com",
      projectId: "ac-baradise-1969",
      storageBucket: "ac-baradise-1969.appspot.com",
      messagingSenderId: "813682247245",
      appId: "1:813682247245:web:f4d0b1e689ce33c82f7e04",
      measurementId: "G-1C3QPLNF4G"

    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AC Baradise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: darkBlueColor),
        useMaterial3: true,
        
      ),
      home: AuthPage(),
    );
  }
}
