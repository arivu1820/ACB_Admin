import 'package:acb_admin/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewCustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;


  NewCustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    
  }) : super(key: key);

  @override
  _NewCustomSwitchState createState() => _NewCustomSwitchState();
}

class _NewCustomSwitchState extends State<NewCustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);

      },
      child: Container(
        width: 75,
        height: 35,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: widget.value ? darkBlueColor : whiteColor,
          border: Border.all(
            color: widget.value ? darkBlueColor : darkBlue50Color,
            width: 2.0,
          ),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment:
              widget.value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.value ? whiteColor : darkBlue50Color,
            ),
          ),
        ),
      ),
    );
  }
}
