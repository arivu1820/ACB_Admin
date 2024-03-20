import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:acb_admin/HomePage.dart';
import 'package:acb_admin/Theme/Colors.dart';

class EmailPasswordSigninBtn extends StatelessWidget {
  const EmailPasswordSigninBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          // Show loading indicator
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: CircularProgressIndicator(
                  color: darkBlueColor,
                ),
              );
            },
          );

          // Authenticate user with email and password
          UserCredential authResult = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
            email: 'test@gmail.com', // Replace with user-entered email
            password: 'testtest', // Replace with user-entered password
          );
          User? user = authResult.user;

          // Hide loading indicator
          Navigator.of(context).pop();

          // Navigate to the next page on successful sign-in
          if (user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ),
            );
          }
        } catch (e) {
          // Hide loading indicator
          Navigator.of(context).pop();

          // Display error message
          print("Error signing in with email and password: $e");

          // Show error dialog
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Failed to sign in. Please try again."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: lightBlueColor,
          borderRadius: BorderRadius.circular(5),
        ),
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text(
            "Continue with Email/Password",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "LexendMedium",
              color: blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
