import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPriceWithout extends StatelessWidget {
  final num orderamount;
  final int count;
  const OrderPriceWithout({Key? key,required this.orderamount,required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
    
       mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        
        Text(
         '₹ ${NumberFormat('#,##,##0.00').format(orderamount)}' ,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: "LexendLight",
            color: blackColor,
          ),
        ),
        Text(
          "Qty: "+count.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontFamily: "LexendLight",
            color: black50Color,
          ),
        ),
      ],
    );
  }
}
