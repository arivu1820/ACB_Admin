import 'dart:typed_data';

import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMCServiceListContainer.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMCUploadContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/BenefitsContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/SingleImageUploadContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AMCSubListContainer extends StatefulWidget {
  final String title,uid,orderid;
  
  final bool sparesincluded;
  final List<dynamic> schemebenefits;
  final String img;

  const AMCSubListContainer(
      {super.key,
      required this.title,
      required this.orderid,
      required this.schemebenefits,
      required this.img,
      required this.uid,
      required this.sparesincluded});

  @override
  State<AMCSubListContainer> createState() => _AMCSubListContainerState();
}

class _AMCSubListContainerState extends State<AMCSubListContainer> {
  Uint8List? _imageBytes;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'LexendMedium',
            fontSize: 24,
            color: blackColor,
          ),
        ),
        if (widget.sparesincluded)
          const Row(
            children: [
              Expanded(child: SizedBox()),
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
        BenefitsContainer(
          schemebenefits: widget.schemebenefits,
        ),
        const SizedBox(
          height: 20,
        ),
        AMCUploadContainer(
          name: 'Image',
          uid: widget.uid,
          img: widget.img,
          orderid: widget.orderid,
        ),
        const SizedBox(
          height: 20,
        ),
        
      ],
    );
  }
}
