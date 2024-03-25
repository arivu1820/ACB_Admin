import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/OrderProductContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final bool isQtyReq;
  final String uid;
  final Map<String, dynamic>? orderdetails;

  Products({
    Key? key,
    required this.isQtyReq,
    required this.uid,
    this.orderdetails,
  });

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
            "Products",
            style: const TextStyle(
              fontFamily: "Stylish",
              fontSize: 18,
              color: darkBlueColor,
            ),
          ),
         buildProductsFromListview() ,
        ],
      ),
    );
  }

  Widget buildProductsFromListview() {
    var products = orderdetails?['Products'] as Map<String, dynamic>?;

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
        String img = productData['img'] ?? '';
        int count = productData['count'] ?? 0;
        num productsorderamount = productData['totalPrice'] ?? 0;

        return OrderProductContainer(
          isQtyReq: isQtyReq,
          count: count,
          title: title,
          uid: uid,
          img: img,
          productsorderamount: productsorderamount,
        );
      },
    );
  }

  
}
