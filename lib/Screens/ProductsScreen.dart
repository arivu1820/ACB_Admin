import 'package:acb_admin/Models/FirebaseService.dart';
import 'package:acb_admin/Screens/AddGeneralProductsScreen.dart';
import 'package:acb_admin/Screens/AddProductCategoryScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/OrdersContainer.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/ProductsCategoryListContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/GeneralProductsListContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ProductsScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: _firebaseService.getProductsCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final categorys = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: categorys.length,
                    itemBuilder: (context, index) {
                      final category = categorys[index];
                    

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddProductCategoryScreen(
                              category: category['Name'],
                              categoryId: category.id,
                              tons: category['Tons'],
                              brands: category['Brands'],
                            ),
                          ),
                        ),
                        child: ProductsCategoryListContainer(categoryId: category.id, title: category["Name"])
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProductCategoryScreen(),
                    ),
                  ),
                  child: Container(
                    width: 300,
                    height: 60,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                      color: darkBlueColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
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
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
