import 'package:acb_admin/Models/DataBaseHelper.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMCServiceListContainer.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMCSubListContainer.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/sharepartnerdialog.dart';
import 'package:acb_admin/Widgets/SingleWidgets/Appbar.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CustomDoneBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CustomSwitch.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/OrdersListContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/newcustomswitch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html;

class AMCSubListScreen extends StatefulWidget {
  final String uid, name, serviceno, number, address, orderid, title, img;
  final DateTime date;
  final bool onprocess, sparesincluded;
  final bool isclaimed, iscompleted,completescreen;
  final List<dynamic> schemebenefits;
  final String lat, lon;
  final Timestamp service1, service2, service3, service4;
  final bool isdone1, isdone2, isdone3, isdone4;

  AMCSubListScreen({
    Key? key,
    required this.uid,
    required this.date,
    this.onprocess = false,
    required this.name,
    required this.sparesincluded,
    required this.completescreen,
    required this.serviceno,
    required this.iscompleted,
    required this.lat,
    required this.lon,
    required this.service1,
    required this.service2,
    required this.service3,
    required this.service4,
    required this.isdone1,
    required this.isdone2,
    required this.isdone3,
    required this.isdone4,
    required this.img,
    required this.number,
    required this.title,
    required this.schemebenefits,
    required this.isclaimed,
    required this.address,
    required this.orderid,
  }) : super(key: key);

  @override
  _OrdersListScreenState createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<AMCSubListScreen> {
  bool switchValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchValue = widget.onprocess;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${widget.serviceno}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'LexendRegular',
                      fontSize: 32,
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(width: 30),
                  if (widget.isclaimed)
                    const Text(
                      "Claimed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'LexendRegular',
                        fontSize: 24,
                        color: leghtGreen,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      "UID: ${widget.uid}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'LexendRegular',
                        fontSize: 14,
                        color: blackColor,
                      ),
                    ),
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
                  if (widget.iscompleted)
                    Image.asset(
                      'Assets/greentick.png',
                      height: 50,
                      width: 50,
                    ),
                ],
              ),
              GestureDetector(
                onTap: widget.iscompleted
                    ? () => SharePartnerDialog.onDutypartner(
                        widget.orderid, context, widget.iscompleted, true)
                    : () => SharePartnerDialog.shareservicepartner(
                        widget.orderid, context, widget.iscompleted, true),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Service Partner',
                      style: TextStyle(
                        fontFamily: 'LexendRegular',
                        fontSize: 20,
                        color: darkBlueColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'Assets/share.png',
                      width: 20,
                      height: 20,
                      color: darkBlueColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              (widget.onprocess && !widget.iscompleted)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "Assets/timer.png",
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "On process",
                          style: TextStyle(
                            fontFamily: 'LexendRegular',
                            fontSize: 20,
                            color: blackColor,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              if (!widget.iscompleted)
                NewCustomSwitch(
                  value: switchValue,
                  onChanged: (newValue) async {
                    setState(() {
                      switchValue = newValue;
                    });
                    // Update Firestore here
                    final CollectionReference subscriptionCollection =
                        FirebaseFirestore.instance
                            .collection('CurrentAMCSubscription');
                    final DocumentReference docRef =
                        subscriptionCollection.doc(widget.orderid);

                    await docRef.update({'onProcess': newValue});
                  },
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontFamily: 'LexendRegular',
                          fontSize: 20,
                          color: blackColor,
                        ),
                      ),
                      Text(
                        '+91 ${widget.number}',
                        style: const TextStyle(
                          fontFamily: 'LexendRegular',
                          fontSize: 20,
                          color: blackColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double maxWidth = constraints.maxWidth;
                          double width = maxWidth < 250 ? maxWidth : 250;

                          return SizedBox(
                            width: width,
                            child: Text(
                              widget.address,
                              style: const TextStyle(
                                fontFamily: 'LexendLight',
                                fontSize: 20,
                                color: blackColor,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => _copyMapUrl(widget.lat, widget.lon),
                        child: Row(
                          children: [
                            const Text(
                              'Location',
                              style: TextStyle(
                                fontFamily: 'LexendRegular',
                                fontSize: 20,
                                color: darkBlueColor,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              'Assets/copy.png',
                              width: 20,
                              height: 20,
                              color: darkBlueColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              AMCSubListContainer(
                title: widget.title,
                img: widget.img,
                uid: widget.uid,
                orderid: widget.orderid,
                sparesincluded: widget.sparesincluded,
                schemebenefits: widget.schemebenefits,
              ),
              AMCServiceListContainer(
                service1: widget.service1,
                orderid: widget.orderid,
                uid: widget.uid,
                service2: widget.service2,
                service3: widget.service3,
                service4: widget.service4,
                isdone1: widget.isdone1,
                isdone2: widget.isdone2,
                isdone3: widget.isdone3,
                isdone4: widget.isdone4,
              ),
              const SizedBox(
                height: 30,
              ),
              if (widget.iscompleted && !widget.completescreen)
                GestureDetector(
                  onTap: () =>
                      DatabaseHelper.remove(context, widget.orderid, true),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                          color: lightGray80Color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Remove',
                            style: TextStyle(
                              fontFamily: 'LexendRegular',
                              fontSize: 20,
                              color: brown50Color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Text(
                '# ${widget.orderid}',
                style: const TextStyle(
                  fontFamily: 'LexendRegular',
                  fontSize: 14,
                  color: blackColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyMapUrl(String lat, String lon) {
    String mapUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    html.window.navigator.clipboard?.writeText(mapUrl).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copied'),
        ),
      );
    }).catchError((error) {
      print('Error copying to clipboard: $error');
    });
  }
}
