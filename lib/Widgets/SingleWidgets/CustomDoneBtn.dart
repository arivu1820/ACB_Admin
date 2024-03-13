import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';

class CustomDoneBtn extends StatelessWidget {
  final bool switchValue;
  const CustomDoneBtn({super.key, required this.switchValue});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (switchValue) {}
      },
      child: Container(
        width: 75,
        height: 35,
        decoration: BoxDecoration(
          color: switchValue ? darkBlueColor : darkBlue50Color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Center(
          child: Text(
            'Done',
            style: TextStyle(
              color: whiteColor,
              fontFamily: 'LexendRegular',
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
