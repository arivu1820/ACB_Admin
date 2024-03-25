import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/CartAMCContainer.dart';

import 'package:flutter/material.dart';

class AMC extends StatelessWidget {
  final bool isQtyReq;
  final String uid;
  final Map<String, dynamic>? orderdetails;

  const AMC(
      {Key? key, this.orderdetails, required this.isQtyReq, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "AMC",
            style: const TextStyle(
              fontFamily: "Stylish",
              fontSize: 18,
              color: darkBlueColor,
            ),
          ),
           buildProductsFromListview(),
        ],
      ),
    );
  }

  Widget buildProductsFromListview() {
    var products = orderdetails?['AMC'] as Map<String, dynamic>?;

    if (products == null) {
      // Handle the case where 'Products' is null or not a Map
      return Container();
    }

    var productIds = products.keys.toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: productIds.length,
      itemBuilder: (context, index) {
        var productId = productIds[index];
        var productData = products[productId] as Map<String, dynamic>;

        if (productData == null) {
          // Handle the case where productData is null
          return Container();
        }

        String title = productData['title'] ?? '';
        int count = productData['count'] ?? 0;
        num amcorderamount = productData['totalPrice'] ?? 0;

        return CartAMCContainer(
          isQtyReq: isQtyReq,
          title: title,
          uid: uid,
          count: count,
          orderamount: amcorderamount,
        );
      },
    );
  }

  
}
