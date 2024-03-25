import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMC.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/GeneralProducts.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/Products.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/Services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderListScreen extends StatelessWidget {
  final String uid;
  final String address;
  final String name;
  final String contact;
  final num totalamount;
  final List orderdetails;

  const OrderListScreen({
    super.key,
    required this.uid,
    required this.address,
    required this.contact,
    required this.name,
    required this.totalamount,
    required this.orderdetails,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            if (orderdetails[3]['GeneralProducts'].isNotEmpty)
              GeneralProducts(
                isQtyReq: true,
                uid: uid,
                orderdetails: orderdetails[3],
              ),
            if (orderdetails[2]['Products'].isNotEmpty)
              Products(
                isQtyReq: true,
                uid: uid,
                orderdetails: orderdetails[2],
              ),
            if (orderdetails[1]['Services'].isNotEmpty)
              Services(
                uid: uid,
                orderdetails: orderdetails[1],
              ),
            if (orderdetails[0]['AMC'].isNotEmpty)
              AMC(
                isQtyReq: true,
                uid: uid,
                orderdetails: orderdetails[0],
              ),
            Column(
              children: [
                const Text(
                  'Total amount',
                  style: TextStyle(
                      fontFamily: 'LexendRegular',
                      fontSize: 22,
                      color: blackColor),
                ),
                Text(
                  '₹ ${NumberFormat('#,##,##0.00').format(totalamount)}',
                  style: const TextStyle(
                      fontFamily: 'LexendBold',
                      fontSize: 22,
                      color: blackColor),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
