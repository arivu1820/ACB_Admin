import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMCServiceListContainer.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMCUploadContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/BenefitsContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AMCSubListContainer extends StatelessWidget {
  const AMCSubListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text('data',style
        :const TextStyle(
            fontFamily: 'LexendSemiBold',
            fontSize: 32,
            color: blackColor,
          ),),
       const Row(
          children: [
            Expanded(child:  SizedBox()),
             Text(
              'Include Total Spares',
              style: TextStyle(
                fontFamily: 'LexendSemiBold',
                fontSize: 20,
                color: leghtGreen,
              ),
            ),
          ],
        ),
        BenefitsContainer(),
        const SizedBox(
          height: 20,
        ),
        AMCUploadContainer(),
        const SizedBox(
          height: 20,
        ),
        AMCServiceListContainer(),
      ],
    );
  }
}
