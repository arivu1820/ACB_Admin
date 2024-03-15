import 'package:acb_admin/Screens/AddProductCategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:acb_admin/Screens/AddGeneralProductsScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/OrdersContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/GeneralProductsListContainer.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/ProductsCategoryListContainer.dart';
import 'package:intl/intl.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: whiteColor,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProductCategoryScreen()),
                  ),
                  child: ProductsCategoryListContainer(
                    title: 'Split AC',
                  ),
                ),
                itemCount: 13,
              ),
            ),
            Container(
              width: 300,
              height: 60,
             margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: darkBlueColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'Add Category',
                  style: TextStyle(
                    fontFamily: 'LexendRegular',
                    fontSize: 20,
                    color: blackColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
