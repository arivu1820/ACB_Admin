import 'package:acb_admin/Models/FirebaseService.dart';
import 'package:acb_admin/Screens/OrdersListScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/OrdersContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: whiteColor,
        body: StreamBuilder<QuerySnapshot>(
          stream: _firebaseService.getCurrentOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text(
                'No orders available',
                style: TextStyle(
                    color: blackColor,
                    fontFamily: 'LexendRegular',
                    fontSize: 20),
              ));
            } else {
              List<QueryDocumentSnapshot> orders = snapshot.data!.docs.toList();
              // Sort orders by timestamp in ascending order
              orders.sort((a, b) => (a['CreatedAt'] as Timestamp)
                  .compareTo(b['CreatedAt'] as Timestamp));

              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final ordertime = (order['CreatedAt'] as Timestamp)
                      .toDate(); // Convert timestamp to DateTime
                  final onProcess = (order.data() as Map<String, dynamic>)
                          .containsKey('onProcess')
                      ? order['onProcess']
                      : false; // Check if 'onprocess' field exists

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdersListScreen(
                          orderid: order.id,
                          process: onProcess,
                        ),
                      ),
                    ),
                    child: OrdersContainer(
                      name: order['name'],
                      number: order['contact'],
                      address: order['address'],
                      date: ordertime,
                      orderid: order.id,
                      onprocess: onProcess,
                    ),
                  );
                },
              );
            }
          },
        ),
      );
}
