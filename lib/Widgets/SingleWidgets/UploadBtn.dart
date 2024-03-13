import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';

class UploadBtn extends StatelessWidget {
  const UploadBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: darkBlueColor),
      height: 50,
      width: 140,
      child: const Center(
          child: Text('Upload',
              style: TextStyle(
                color: whiteColor,
                fontFamily: 'LexendRegular',
                fontSize: 20,
              ))),
    );
  }
}
