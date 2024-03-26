import 'package:acb_admin/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SharePartnerDialog {
  static Future<void> shareservicepartner(String orderid, BuildContext context,
      bool orderiscompleted, bool isamc) async {
    List<Map<String, String>> selectedPartners = [];

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('ServicePartner').get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<DocumentSnapshot> partners = snapshot.data!.docs;
              return AlertDialog(
                title: Text('Select Service Partners'),
                content: SingleChildScrollView(
                  child: Column(
                    children: partners.map((partner) {
                      String partnerName = partner['name'] ?? '';
                      String partnerId =
                          partner.id; // Unique ID of the partner document
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return CheckboxListTile(
                            title: Text(partnerName),
                            value: selectedPartners
                                .any((element) => element['id'] == partnerId),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value ?? false) {
                                  selectedPartners.add(
                                      {'id': partnerId, 'name': partnerName});
                                } else {
                                  selectedPartners.removeWhere(
                                      (element) => element['id'] == partnerId);
                                }
                              });
                            },
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onDutypartner(orderid, context, orderiscompleted, isamc);
                    },
                    child: const Text(
                      'View OnDuty Partner',
                      style: TextStyle(color: leghtGreen),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await shareOrderDetailsWithPartners(
                          orderid, selectedPartners, isamc);

                      Navigator.of(context).pop();
                      onDutypartner(orderid, context, orderiscompleted, isamc);
                    },
                    child: Text('Share'),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }

  static Future<void> shareOrderDetailsWithPartners(String orderid,
      List<Map<String, String>> selectedPartners, bool isamc) async {
    // Get order details from CurrentOrders collection
    if (isamc) {
      DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('CurrentAMCSubscription')
          .doc(orderid)
          .get();
      Map<String, dynamic> orderDetails =
          orderSnapshot.data() as Map<String, dynamic>;

      // Share order details with selected partners
      for (Map<String, String> partnerData in selectedPartners) {
        String? partnerId = partnerData['id'];
        String? partnerName = partnerData['name'];

        // Set order details in CurrentOrdersDetails subcollection for the partner
        await FirebaseFirestore.instance
            .collection('ServicePartner')
            .doc(partnerId)
            .collection('CurrentAMCOrdersDetails')
            .doc(orderid)
            .set({
          ...orderDetails, // Assuming orderDetails is a Map<String, dynamic>
          'currentTime': DateTime.now(), // Add current time field
        });

        // Create document in OnDutyPartner subcollection
        await FirebaseFirestore.instance
            .collection('CurrentAMCSubscription')
            .doc(orderid)
            .collection('OnDutyPartner')
            .doc(partnerId)
            .set({
          'name': partnerName, // Use partner's name from selectedPartners
          'completed': false,
        });
      }
    } else {
      DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('CurrentOrders')
          .doc(orderid)
          .get();
      Map<String, dynamic> orderDetails =
          orderSnapshot.data() as Map<String, dynamic>;

      // Share order details with selected partners
      for (Map<String, String> partnerData in selectedPartners) {
        String? partnerId = partnerData['id'];
        String? partnerName = partnerData['name'];

        // Set order details in CurrentOrdersDetails subcollection for the partner
        await FirebaseFirestore.instance
            .collection('ServicePartner')
            .doc(partnerId)
            .collection('CurrentOrdersDetails')
            .doc(orderid)
            .set({
          ...orderDetails, // Assuming orderDetails is a Map<String, dynamic>
          'currentTime': DateTime.now(), // Add current time field
        });

        // Create document in OnDutyPartner subcollection
        await FirebaseFirestore.instance
            .collection('CurrentOrders')
            .doc(orderid)
            .collection('OnDutyPartner')
            .doc(partnerId)
            .set({
          'name': partnerName, // Use partner's name from selectedPartners
          'completed': false,
        });
      }
    }
  }

  static Future<void> onDutypartner(String orderid, BuildContext context,
      bool isordercompleted, bool isamc) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<QuerySnapshot>(
          future: isamc
              ? FirebaseFirestore.instance
                  .collection('CurrentAMCSubscription')
                  .doc(orderid)
                  .collection('OnDutyPartner')
                  .get()
              : FirebaseFirestore.instance
                  .collection('CurrentOrders')
                  .doc(orderid)
                  .collection('OnDutyPartner')
                  .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<DocumentSnapshot> partners = snapshot.data!.docs;
              return AlertDialog(
                title: const Text('OnDuty Partners'),
                content: SingleChildScrollView(
                  child: Column(
                    children: partners.map((partner) {
                      String partnerName = partner['name'] ?? '';
                      bool completed = partner['completed'] ?? false;
                      return ListTile(
                        title: Text(partnerName),
                        subtitle: Text(
                          completed ? 'Completed' : 'InDuty',
                          style: TextStyle(
                              fontFamily: 'LexendRegular',
                              fontSize: 14,
                              color: completed ? leghtGreen : darkBlueColor),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                actions: <Widget>[
                  if (!isordercompleted)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        shareservicepartner(orderid, context, isordercompleted,
                            isamc); // Close the dialog
                      },
                      child: const Text('Back'),
                    ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
