import 'package:acb_admin/Models/FirebaseService.dart';
import 'package:acb_admin/Screens/AddProductScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CommonListContioner.dart';
import 'package:flutter/widgets.dart';

class ListItemsandAddItems extends StatelessWidget {
  final String category;
  final String name;
  final String categoryId;
  final Widget screen;

  ListItemsandAddItems({
    Key? key,
    required this.category,
    required this.screen,
    required this.name,
    required this.categoryId,
  }) : super(key: key);

  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '$name',
                    style: const TextStyle(
                      fontFamily: 'LexendRegular',
                      fontSize: 20,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => screen),
                ),
                child: Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: darkBlueColor,
                  ),
                  child: Center(
                    child: Text(
                      'Add $category',
                      style: const TextStyle(
                        fontFamily: 'LexendRegular',
                        fontSize: 20,
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          categoryId.isNotEmpty
              ? StreamBuilder<QuerySnapshot>(
                  stream: _firebaseService.getProducts(categoryId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final products = snapshot.data!.docs;
                      if (products.isEmpty) {
                        return const Center(
                          child: Text("No Items Listed"),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddProductScreen(
                                    name: product['Name'],
                                    discount: product['Discount'],
                                    stock: product['Stock'],
                                    categoryId: categoryId,
                                    docId: product.id,
                                    overview: product['Overview'],
                                    ton: product['Ton'],
                                    brand: product['Brand'],
                                    mrp: product['MRP'],
                                    Specification: product['Specification'],
                                    imgs: product['Images'],
                                  ),
                                ),
                              ),
                              child: CommonListContainer(
                                title: product['Name'],
                                productId: product.id,
                                categoryId: categoryId,
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                )
              : const Center(
                  child: Text("No Items Listed"),
                ),
        ],
      ),
    );
  }
}
