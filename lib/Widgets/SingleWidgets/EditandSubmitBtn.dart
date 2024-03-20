import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';

class EditandSumbitBtn extends StatefulWidget {
  final VoidCallback? onEditPressed;
  final VoidCallback? onSubmitPressed;
  // final String servicebannerurl;

  EditandSumbitBtn(
      {Key? key,
      this.onEditPressed,
      // this.servicebannerurl = '',
      this.onSubmitPressed})
      : super(key: key);

  @override
  State<EditandSumbitBtn> createState() => _EditandSumbitBtnState();
}

class _EditandSumbitBtnState extends State<EditandSumbitBtn> {
  bool iseditmode = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                widget.onEditPressed!();
                setState(() {
                  iseditmode = !iseditmode;
                });
              },
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: iseditmode ? darkBlueColor : darkGrey50Color),
                child: const Center(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                        fontFamily: 'LexendRegular',
                        fontSize: 20,
                        color: blackColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            GestureDetector(
              onTap: () {
                widget.onSubmitPressed!();
                setState(() {
                  iseditmode = !iseditmode;
                });
              },
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: !iseditmode ? leghtGreen : darkBlue10Color),
                child: const Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontFamily: 'LexendRegular',
                        fontSize: 20,
                        color: blackColor),
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
