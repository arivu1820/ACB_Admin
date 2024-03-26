import 'package:acb_admin/Models/DataBaseHelper.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AMCCustomDoneBtn extends StatefulWidget {
  final bool switchValue;
  final String orderid, serviceno, changeserviceno;
  final String uid;
  final DateTime date;

  const AMCCustomDoneBtn({
    Key? key,
    required this.switchValue,
    required this.serviceno,
    required this.orderid,
    required this.changeserviceno,
    required this.uid,
    required this.date,
  }) : super(key: key);

  @override
  State<AMCCustomDoneBtn> createState() => _AMCCustomDoneBtnState();
}

class _AMCCustomDoneBtnState extends State<AMCCustomDoneBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.switchValue) {
          await amcorderCompleted(
            widget.orderid,
            context,
            widget.uid,
            widget.serviceno,
            widget.date,
          );
        }
      },
      child: Container(
        width: 75,
        height: 35,
        decoration: BoxDecoration(
          color: widget.switchValue ? darkBlueColor : darkBlue50Color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Center(
          child: Text(
            'Done',
            style: TextStyle(
              color: whiteColor,
              fontFamily: 'LexendRegular',
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> amcorderCompleted(
    String orderid,
    BuildContext context,
    String uid,
    String serviceno,
    DateTime date,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Did service completed successfully?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('CurrentAMCSubscription')
                    .doc(orderid)
                    .update({
                  'Claimed': false,
                  'onProcess': false,
                  serviceno: {'IsDone': true, 'Timestamp': date},
                  'serviceNo': widget.changeserviceno,
                  'onProcess': false,
                  if (serviceno == 'Service12') 'Completed': true
                }).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Updated successfully'),
                    ),
                  );
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Failed to updated, Check your network connection'),
                    ),
                  );
                });
                final userRef =
                    FirebaseFirestore.instance.collection('Users').doc(uid);
                final subscriptionCollection =
                    userRef.collection('AMC Subscription');
                final subscriptionsSnapshot =
                    await subscriptionCollection.get();

                bool matchFound = false;

                for (final subscriptionDoc in subscriptionsSnapshot.docs) {
                  final schemeCollection =
                      subscriptionDoc.data()?['SchemeCollection'];

                  if (schemeCollection != null && !matchFound) {
                    schemeCollection.forEach((key, value) async {
                      if (key == orderid) {
                        final service0 = value['Service0'];
                        final service4 = value['Service4'];
                        final service8 = value['Service8'];
                        final service12 = value['Service12'];

                        if (service0 != null &&
                            serviceno == 'Service0' &&
                            !matchFound) {
                          await updateIsDoneField(subscriptionDoc.id, key,
                              'Service0', uid, 'Claimed1', false);
                          matchFound =
                              true; // Set matchFound to true and exit loop
                          return; // Exit forEach loop
                        } else if (service4 != null &&
                            serviceno == 'Service4' &&
                            !matchFound) {
                          await updateIsDoneField(subscriptionDoc.id, key,
                              'Service4', uid, 'Claimed2', false);
                          matchFound =
                              true; // Set matchFound to true and exit loop
                          return; // Exit forEach loop
                        } else if (service8 != null &&
                            serviceno == 'Service8' &&
                            !matchFound) {
                          await updateIsDoneField(subscriptionDoc.id, key,
                              'Service8', uid, 'Claimed3', false);
                          matchFound =
                              true; // Set matchFound to true and exit loop
                          return; // Exit forEach loop
                        } else if (service12 != null &&
                            serviceno == 'Service12' &&
                            !matchFound) {
                          await updateIsDoneField(subscriptionDoc.id, key,
                              'Service12', uid, 'Claimed4', true);
                          matchFound =
                              true; // Set matchFound to true and exit loop
                          return; // Exit forEach loop
                        }
                      }
                    });
                  }

                  if (matchFound) {
                    break; // Exit the outer loop if match found
                  }
                }

                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateIsDoneField(String docid, String orderId,
      String serviceField, String uid, String claimed, bool is4th) async {
    // Map<String, dynamic> updatevalue = {
    //   serviceField: {'IsDone': true}
    // };
    // Map<String, dynamic> ordervalue = {orderId: updatevalue};

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('AMC Subscription')
        .doc(docid)
        .update({
      'SchemeCollection.$orderId.$serviceField.IsDone': true,
      'SchemeCollection.$orderId.$claimed': true,
      if (is4th) 'SchemeCollection.$orderId.Avail': false,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Updated to user successfully'),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Failed to updated user, Check your network connection'),
        ),
      );
    });
  }
}
