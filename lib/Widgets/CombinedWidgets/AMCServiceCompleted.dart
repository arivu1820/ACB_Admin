import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CustomDoneBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CustomSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AMCServiceCompleted extends StatefulWidget {
  final DateTime date;
  const AMCServiceCompleted({super.key, required this.date});

  @override
  _AMCServiceCompletedState createState() => _AMCServiceCompletedState();
}

class _AMCServiceCompletedState extends State<AMCServiceCompleted> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              child: Text(
            '1st Service',
            style: const TextStyle(
              color: blackColor,
              fontFamily: 'LexendRegular',
              fontSize: 20,
            ),
          )),
          CustomSwitch(value: switchValue, onChanged: _onSwitchChanged),
          const SizedBox(
            width: 10,
          ),
          Text(
            DateFormat('MMM yyyy').format(widget.date),
            style: const TextStyle(
              fontFamily: 'LexendRegular',
              fontSize: 20,
              color: blackColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          // CustomDoneBtn(switchValue: switchValue),
          const SizedBox(
            width: 10,
          ),
          Image.asset(
            'Assets/greentick.png',
            height: 35,
            width: 35,
          )
        ],
      ),
    );
  }

  void _onSwitchChanged(bool value) {
    setState(() {
      switchValue = value;
    });
  }
}
