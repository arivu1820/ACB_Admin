import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMCSubListContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CustomDoneBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CustomSwitch.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/OrdersListContainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AMCSubListScreen extends StatefulWidget {
  final String uid, name, serviceno, number, email, address, orderid;
  final DateTime date;
  final bool onprocess;

  AMCSubListScreen({
    Key? key,
    required this.uid,
    required this.date,
    this.onprocess = false,
    required this.name,
    required this.serviceno,
    required this.number,
    required this.email,
    required this.address,
    required this.orderid,
  }) : super(key: key);

  @override
  _OrdersListScreenState createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<AMCSubListScreen> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
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
                ],
              ),
              const SizedBox(height: 20),
              widget.onprocess
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
                      Text(
                        widget.email,
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
                    ],
                  ),
                ],
              ),
AMCSubListContainer(),
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
            ],
          ),
        ),
      ),
    );
  }
}
