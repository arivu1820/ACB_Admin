import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class OrdersContainer extends StatelessWidget {
  final String name;
  final String number;
  final String address;
  final String orderid;
  final DateTime date;
  final bool onprocess;

  OrdersContainer({
    super.key,
    required this.name,
    required this.number,
    required this.address,
    required this.date,
    required this.orderid,
     this.onprocess=false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: whiteColor,
        border: Border(
          bottom: BorderSide(width: 2.0, color: darkBlueColor),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'LexendRegular',
                    fontSize: 20,
                    color: blackColor,
                  ),
                ),
              ),
              const SizedBox(width: 20),
             onprocess?  Row(
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
              ):Container(),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '+91 $number',
            style: const TextStyle(
              fontFamily: 'LexendRegular',
              fontSize: 20,
              color: blackColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            address,
            style: const TextStyle(
              fontFamily: 'LexendLight',
              fontSize: 20,
              color: blackColor,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              const Spacer(),
              FittedBox(
                child: Text(
                  orderid,
                  style: const TextStyle(
                    fontFamily: 'LexendRegular',
                    fontSize: 14,
                    color: black50Color,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                DateFormat('dd MMM yyyy').format(date),
                style: const TextStyle(
                  fontFamily: 'LexendRegular',
                  fontSize: 20,
                  color: blackColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
