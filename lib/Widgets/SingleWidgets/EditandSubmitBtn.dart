import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';

class EditandSumbitBtn extends StatelessWidget {
  final VoidCallback? onEditPressed;
  final VoidCallback? onSubmitPressed;

  const EditandSumbitBtn({Key? key, this.onEditPressed, this.onSubmitPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20,right:20,left:20),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: onEditPressed,
              child: Container(
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
            ),
            const SizedBox(
              width:50,
            ),
            GestureDetector(
              onTap: onSubmitPressed,
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}