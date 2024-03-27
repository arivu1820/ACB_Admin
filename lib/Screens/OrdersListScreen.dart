import 'package:acb_admin/Models/DataBaseHelper.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/sharepartnerdialog.dart';
import 'package:acb_admin/Widgets/SingleWidgets/Appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acb_admin/Models/FirebaseService.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CustomDoneBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CustomSwitch.dart';

import 'package:acb_admin/Widgets/CombinedWidgets/OrdersListContainer.dart';
import 'dart:html' as html;

class OrdersListScreen extends StatefulWidget {
  final String orderid;
  final bool process;
  final bool orderiscompleted;

  OrdersListScreen({
    Key? key,
    required this.orderid,
    required this.process,
    this.orderiscompleted = false,
  }) : super(key: key);

  @override
  _OrdersListScreenState createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  bool switchValue = false; // Initialize switch state

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      switchValue = widget.process;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final FirebaseService _firebaseService = FirebaseService();

    return Scaffold(
      appBar: AppBarWidget(),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firebaseService.getOrderdetails(
            widget.orderid, widget.orderiscompleted),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            String uid = data['UID'];
            DateTime date = (data['CreatedAt'] as Timestamp).toDate();
            final onprocess = data.containsKey('onProcess')
                ? data['onProcess']
                : false; // Check if 'onprocess' field exists
            final completed =
                data.containsKey('Completed') ? data['Completed'] : false;
            String name = data['name'];
            String number = data['contact'];
            String email = data['email'];
            String address = data['address'];
            String ispaid = data['orderPayment'];
            String lat = data['lat'];
            String lon = data['lon'];
            num totalamount = data['totalamount'];
            List orderdetails = data['OrderDetails'];

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "UID: $uid",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'LexendRegular',
                            fontSize: 14,
                            color: blackColor,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          DateFormat('dd MMM yyyy HH:mm a').format(date),
                          style: const TextStyle(
                            fontFamily: 'LexendRegular',
                            fontSize: 20,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    (onprocess && !widget.orderiscompleted)
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontFamily: 'LexendRegular',
                                fontSize: 20,
                                color: blackColor,
                              ),
                            ),
                            Text(
                              '+91 $number',
                              style: const TextStyle(
                                fontFamily: 'LexendRegular',
                                fontSize: 20,
                                color: blackColor,
                              ),
                            ),
                            Text(
                              email,
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
                                    address,
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
                              onTap: () => _copyMapUrl(lat, lon),
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
                        const Spacer(),
                        Column(
                          children: [
                            completed
                                ? const Text(
                                    'Completed',
                                    style: TextStyle(
                                      fontFamily: 'LexendMedium',
                                      fontSize: 20,
                                      color: leghtGreen,
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 10,
                            ),
                            if (!widget.orderiscompleted)
                              CustomSwitch(
                                value: switchValue,
                                onChanged: (newValue) async {
                                  setState(() {
                                    switchValue = newValue;
                                  });
                                  // Update Firestore here
                                  await _firebaseService.updateOrderOnProcess(
                                      widget.orderid, newValue);
                                },
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (!widget.orderiscompleted)
                              CustomDoneBtn(
                                switchValue: switchValue,
                                orderid: widget.orderid,
                                uid: uid,
                                method: ispaid,
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: widget.orderiscompleted
                                  ? () => SharePartnerDialog.onDutypartner(
                                      widget.orderid,
                                      context,
                                      widget.orderiscompleted,
                                      false)
                                  : () =>
                                      SharePartnerDialog.shareservicepartner(
                                          widget.orderid,
                                          context,
                                          widget.orderiscompleted,
                                          false),
                              child: Row(
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
                          ],
                        ),
                      ],
                    ),
                    ispaid == 'offline'
                        ? const Text(
                            'Payment Pending',
                            style: TextStyle(
                                fontFamily: 'LexendMedium',
                                fontSize: 20,
                                color: darkBlueColor),
                          )
                        : ispaid == 'cancel'
                            ? const Text(
                                'Canceled',
                                style: TextStyle(
                                    fontFamily: 'LexendMedium',
                                    fontSize: 20,
                                    color: brownColor),
                              )
                            : ispaid == 'online'
                                ? const Text(
                                    'Paid Online',
                                    style: TextStyle(
                                        fontFamily: 'LexendMedium',
                                        fontSize: 20,
                                        color: leghtGreen),
                                  )
                                : ispaid == 'confirm'
                                    ? const Text(
                                        'Paid COD',
                                        style: TextStyle(
                                            fontFamily: 'LexendMedium',
                                            fontSize: 20,
                                            color: leghtGreen),
                                      )
                                    : const Text(
                                        'Status Not Updated',
                                        style: TextStyle(
                                            fontFamily: 'LexendMedium',
                                            fontSize: 20,
                                            color: blackColor),
                                      ),
                    OrderListScreen(
                        uid: uid,
                        address: address,
                        contact: number,
                        name: name,
                        totalamount: totalamount,
                        orderdetails: orderdetails),
                    const SizedBox(
                      height: 30,
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
                    if (!widget.orderiscompleted)
                      Row(
                        children: [
                          if (completed)
                            GestureDetector(
                              onTap: () => DatabaseHelper.remove(
                                context,
                                widget.orderid,false
                              ),
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
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              await DatabaseHelper.cancel(
                                  widget.orderid, uid, context);
                            },
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
                                      'Cancel Order',
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
                        ],
                      )
                  ],
                ),
              ),
            );
          }
        },
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
