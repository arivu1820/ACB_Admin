import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CustomDoneBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CustomSwitch.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/OrdersListContainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersListScreen extends StatefulWidget {
  final String uid;
  final DateTime date;
  final bool onprocess;
  final String name;
  final String number;
  final String email;
  final String address;
  final String orderid;

  OrdersListScreen({
    Key? key,
    required this.address,
    required this.date,
    required this.email,
    required this.name,
    required this.orderid,
    required this.number,
    this.onprocess = false,
    required this.uid,
  }) : super(key: key);

  @override
  _OrdersListScreenState createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  bool switchValue = true; // Initialize switch state

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
                children: [
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
                    DateFormat('dd MMM yyyy').format(widget.date),
                    style: const TextStyle(
                      fontFamily: 'LexendRegular',
                      fontSize: 20,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
             widget.onprocess? Row(
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
              ): const SizedBox(),
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
                  const Spacer(),
                  Column(
                    children: [
                      CustomSwitch(
                        value: switchValue,
                        onChanged: (newValue) {
                          setState(() {
                            switchValue = newValue;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomDoneBtn(switchValue: switchValue),
                    ],
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => const OrdersListContainer(),
                itemCount: 2,
              ),
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
