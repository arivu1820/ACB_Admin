import 'package:acb_admin/Models/DataBaseHelper.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';

class CustomDoneBtn extends StatelessWidget {
  final bool switchValue;
  final String orderid;
  final String uid; 
  final String method;// User ID
  
  const CustomDoneBtn({Key? key, required this.switchValue, required this.orderid, required this.uid,required this.method}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (switchValue) {
          DatabaseHelper.orderCompleted(orderid, method, context, uid);
        }
          
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
