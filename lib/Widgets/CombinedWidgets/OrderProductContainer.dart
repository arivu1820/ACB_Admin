
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/OrderPriceWithout.dart';
import 'package:flutter/material.dart';

class OrderProductContainer extends StatelessWidget {
  final bool isQtyReq;
  final String productid;
  final String uid;
    final int count;
    final num productsorderamount;

  final String title;
  final String img;
  OrderProductContainer({super.key,this.productsorderamount =0, required this.isQtyReq,this.count=0,this.productid='',required this.title,required this.uid,required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 80,
            child: Image.network(
              img,
              height: 70,
              width: 110,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
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
           OrderPriceWithout(orderamount: productsorderamount,count: count,) ,
        ],
      ),
    );
  }
}
