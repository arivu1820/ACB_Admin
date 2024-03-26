import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMCServiceCompleted.dart';
import 'package:acb_admin/Widgets/SingleWidgets/UploadBtn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AMCServiceListContainer extends StatelessWidget {
  final Timestamp service1, service2, service3, service4;
  final bool isdone1, isdone2, isdone3, isdone4;
  final String orderid, uid;

  AMCServiceListContainer({
    super.key,
    required this.service1,
    required this.service2,
    required this.service3,
    required this.service4,
    required this.orderid,
    required this.uid,
    required this.isdone1,
    required this.isdone2,
    required this.isdone3,
    required this.isdone4,
  });

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
              AMCServiceCompleted(
                date: service1.toDate(),
                serviceno: '1st Service',
                isdone: isdone1,
                uid: uid,
                orderid: orderid,
                servicemapid: 'Service0',
                changeserviceno: '2nd Service',
              ),
              AMCServiceCompleted(
                date: service2.toDate(),
                serviceno: '2nd Service',
                isdone: isdone2,
                uid: uid,
                orderid: orderid,
                servicemapid: 'Service4',
                changeserviceno: '3rd Service',
              ),
              AMCServiceCompleted(
                date: service3.toDate(),
                serviceno: '3rd Service',
                isdone: isdone3,
                uid: uid,
                orderid: orderid,
                servicemapid: 'Service8',
                changeserviceno: '4th Service',
              ),
              AMCServiceCompleted(
                date: service4.toDate(),
                serviceno: '4th Service',
                isdone: isdone4,
                uid: uid,
                orderid: orderid,
                servicemapid: 'Service12',
                changeserviceno: '4th Service',
              ),
            ],
          )),
    );
  }
}
