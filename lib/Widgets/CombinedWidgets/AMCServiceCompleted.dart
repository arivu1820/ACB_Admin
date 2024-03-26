import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/AMCCustomBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CustomSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AMCServiceCompleted extends StatefulWidget {
  final DateTime date;
  final String serviceno, orderid, uid, servicemapid,changeserviceno;

  final bool isdone;

  const AMCServiceCompleted(
      {super.key,
      required this.date,
      required this.serviceno,
      required this.servicemapid,
      required this.uid,
      required this.changeserviceno,
      required this.orderid,
      required this.isdone});

  @override
  _AMCServiceCompletedState createState() => _AMCServiceCompletedState();
}

class _AMCServiceCompletedState extends State<AMCServiceCompleted> {
  bool switchValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchValue = widget.isdone;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              child: Text(
            widget.serviceno,
            style: const TextStyle(
              color: blackColor,
              fontFamily: 'LexendRegular',
              fontSize: 20,
            ),
          )),
          if (!widget.isdone)
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
          if (!widget.isdone)
            AMCCustomDoneBtn(
              switchValue: switchValue,
              orderid: widget.orderid,
              uid: widget.uid,
              serviceno: widget.servicemapid,
              changeserviceno: widget.changeserviceno,
              date: widget.date,
            ),
          const SizedBox(
            width: 10,
          ),
          if (widget.isdone)
            Image.asset(
              'Assets/greentick.png',
              height: 35,
              width: 35,
            )
        ],
      ),
    );
  }

void _onSwitchChanged(bool value) async {
  setState(() {
    switchValue = value;
  });

}
}
