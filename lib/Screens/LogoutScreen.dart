import 'package:acb_admin/Authentication/SigninScreen.dart';
import 'package:acb_admin/Authentication/auth_page.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogoutScreen extends StatelessWidget {
   LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          try {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return AuthPage();
                      }));
                    } on FirebaseAuthException catch (e) {
                      throw e.message!;
                    } catch (e) {
                      throw "Unable to logout, Try again";
                    }
        },
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(color: darkGrey50Color,borderRadius: BorderRadius.circular(10)),
          child:const Center(child: Text('Logout',style: TextStyle(color: blackColor,fontFamily: 'LexendMedium',fontSize: 20),)),
        ),
      ),
    );
  }
}