import 'package:acb_admin/Models/FirebaseService.dart';
import 'package:acb_admin/Screens/AMCSubListScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMCSubContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AMCSubScreen extends StatefulWidget {
  @override
  State<AMCSubScreen> createState() => _AMCSubScreenState();
}

class _AMCSubScreenState extends State<AMCSubScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  //   Future<void> _refresh() async {
  //   setState(() {
  //     // No specific action, just trigger setState to rebuild StreamBuilder
  //   });
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: whiteColor,
        body: StreamBuilder<QuerySnapshot>(
          stream: _firebaseService.getCurrentAMCSubscription(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text(
                'No Subscription Available',
                style: TextStyle(
                    color: blackColor,
                    fontFamily: 'LexendRegular',
                    fontSize: 20),
              ));
            } else {
              List<QueryDocumentSnapshot> subs = snapshot.data!.docs.toList();
        
              // Custom comparison function for sorting
              subs.sort((a, b) {
                // Sort claimed documents first
                final claimedA = a['Claimed'] ?? false;
                final claimedB = b['Claimed'] ?? false;
                if (claimedA != claimedB) {
                  return claimedA ? -1 : 1; // Sort claimed first
                } else {
                  // Sort by service status and timestamp within each group
                  final serviceA = a['Service0'] ??
                      a['Service4'] ??
                      a['Service8'] ??
                      a['Service12'];
                  final serviceB = b['Service0'] ??
                      b['Service4'] ??
                      b['Service8'] ??
                      b['Service12'];
        
                  final isDoneA =
                      serviceA != null && serviceA['IsDone'] ?? false;
                  final isDoneB =
                      serviceB != null && serviceB['IsDone'] ?? false;
        
                  // If both are done or both are not done, sort by timestamp
                  if (isDoneA == isDoneB) {
                    final createdAtA =
                        serviceA != null ? serviceA['Timestamp'] : null;
                    final createdAtB =
                        serviceB != null ? serviceB['Timestamp'] : null;
                    return (createdAtA as Timestamp)
                        .compareTo(createdAtB as Timestamp);
                  } else {
                    // Sort by IsDone status
                    return isDoneA ? 1 : -1;
                  }
                }
              });
        
              return ListView.builder(
                itemCount: subs.length,
                itemBuilder: (context, index) {
                  final order = subs[index];
                  // final ordertime = (order['Timestamp'] as Timestamp)
                  //     .toDate(); // Convert timestamp to DateTime
                  final onProcess = (order.data() as Map<String, dynamic>)
                          .containsKey('onProcess')
                      ? order['onProcess']
                      : false; // Check if 'onprocess' field exists
                  final iscompleted = (order.data() as Map<String, dynamic>)
                          .containsKey('Completed')
                      ? order['Completed']
                      : false;
                  final serviceNo = (order.data() as Map<String, dynamic>)
                          .containsKey('serviceNo')
                      ? order['serviceNo']
                      : '1st Service';
        
                  late DateTime ordertime;
        
                  ordertime = (order['Service0'] != null &&
                          order['Service0']['IsDone'] != true)
                      ? (order['Service0']['Timestamp'] as Timestamp).toDate()
                      : (order['Service4'] != null &&
                              order['Service4']['IsDone'] != true)
                          ? (order['Service4']['Timestamp'] as Timestamp)
                              .toDate()
                          : (order['Service8'] != null &&
                                  order['Service8']['IsDone'] != true)
                              ? (order['Service8']['Timestamp'] as Timestamp)
                                  .toDate()
                              : (order['Service12']['Timestamp'] as Timestamp)
                                  .toDate();
        
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AMCSubListScreen(
                          completescreen: false,
                          service1: order['Service0']['Timestamp'],
                          service2: order['Service4']['Timestamp'],
                          service3: order['Service8']['Timestamp'],
                          service4: order['Service12']['Timestamp'],
                          lat: order['lat'],
                          lon: order['lon'],
                          iscompleted: iscompleted,
                          isdone1: order['Service0']['IsDone'],
                          isdone2: order['Service4']['IsDone'],
                          isdone3: order['Service8']['IsDone'],
                          isdone4: order['Service12']['IsDone'],
                          serviceno: serviceNo,
                          address: order['Address'],
                          sparesincluded: order['SparesIncluded'],
                          date: ordertime,
                          name: order['Name'],
                          number: order['Contact'],
                          uid: order['UID'],
                          img: order['Image'],
                          schemebenefits: order['Benefits'],
                          onprocess: onProcess,
                          orderid: order.id,
                          isclaimed: order['Claimed'],
                          title: order['Title'],
                        ),
                      ),
                    ),
                    child: AMCSubContainer(
                        isclaimed: order['Claimed'],
                        onprocess: onProcess,
                        iscompleted: iscompleted,
                        serviceno: serviceNo,
                        name: order['Name'],
                        number: order['Contact'],
                        address: order['Address'],
                        date: ordertime,
                        orderid: order.id),
                  );
                },
              );
            }
          },
        ),
      );
}
