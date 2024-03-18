import 'package:acb_admin/Models/FirebaseService.dart';
import 'package:acb_admin/Screens/AddGeneralProductsScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/OrdersContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/GeneralProductsListContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GeneralProductsScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: _firebaseService.getGeneralProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final products = snapshot.data!.docs;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddGeneralProductsScreen(),
                    ),
                  ),
                  child: GeneralProductsListContainer(
                    img: product['Image'], // Assuming 'image' is the field containing the image URL
                    title: product['Name'], // Assuming 'name' is the field containing the product name
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
