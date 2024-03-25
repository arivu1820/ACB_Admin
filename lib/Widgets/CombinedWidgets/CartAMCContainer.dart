
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/OrderPriceWithout.dart';
import 'package:flutter/material.dart';

class CartAMCContainer extends StatelessWidget {
  final bool isQtyReq;
  final String productid;
  final String uid;
  final num orderamount;
  final int count;

  final String title;
  CartAMCContainer({super.key, required this.isQtyReq,this.productid='',required this.title,required this.uid,this.orderamount=0, this.count=0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: "LexendLight",
                fontSize: 15,
                color: blackColor,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
         OrderPriceWithout(orderamount: orderamount,count: count,)
        ],
      ),
    );
  }
}
