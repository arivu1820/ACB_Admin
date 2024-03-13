import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMCServiceCompleted.dart';
import 'package:acb_admin/Widgets/SingleWidgets/UploadBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AMCServiceListContainer extends StatelessWidget {
  const AMCServiceListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: darkBlueColor)),
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              AMCServiceCompleted(date: DateTime.now(),),
              AMCServiceCompleted(date: DateTime.now(),),
              AMCServiceCompleted(date: DateTime.now(),),
              AMCServiceCompleted(date: DateTime.now(),),
            ],
          )),
    );
  }
}
