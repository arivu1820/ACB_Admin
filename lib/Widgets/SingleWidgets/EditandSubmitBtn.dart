import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';

class EditandSumbitBtn extends StatelessWidget {
  const EditandSumbitBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: darkGreyColor),
              child: const Center(
                child: Text(
                  'Edit',
                  style: TextStyle(
                      fontFamily: 'LexendRegular', fontSize: 20, color: blackColor),
                ),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: darkBlueColor),
              child: const Center(
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontFamily: 'LexendRegular', fontSize: 20, color: blackColor),
                ),
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
