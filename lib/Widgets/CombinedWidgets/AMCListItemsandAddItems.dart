import 'package:acb_admin/Models/FirebaseService.dart';
import 'package:acb_admin/Screens/AddAMCSchemeScreen.dart';
import 'package:acb_admin/Screens/CommonServicesScreen.dart';
import 'package:acb_admin/Widgets/SingleWidgets/ServiceCommonListContiner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CommonListContioner.dart';
import 'package:flutter/widgets.dart';

class AMCListItemsandAddItems extends StatelessWidget {
  final String category;
  final String name;
  final String categoryId;
  final String categoryName;
  final Widget screen;
  final Stream<QuerySnapshot<Object?>>? ServiceQuerySnapshot;

  AMCListItemsandAddItems({
    Key? key,
    required this.category,
    required this.screen,
    required this.categoryName,
    required this.name,
    required this.ServiceQuerySnapshot,
    required this.categoryId,
  }) : super(key: key);

  // final FirebaseService _firebaseService = FirebaseService();

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
                  stream: ServiceQuerySnapshot,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final services = snapshot.data!.docs;
                      if (services.isEmpty) {
                        return const Center(
                          child: Text("No Items Listed"),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: services.length,
                          itemBuilder: (context, index) {
                            final service = services[index]['Content'];
                            final serviceId = services[index].id;

                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAMCSchemeScreen(
                                        benefits: service['Benefits'] ?? [],
                                        discount: service['Discount'] ?? 0,
                                        imgs: service['Images'] ?? [],
                                        mrp: service['MRP'] ?? 0,
                                        overviewcontent:
                                            service['OverviewContent'] ?? '',
                                        docId: serviceId,
                                        title: service['Title'] ?? '',
                                        totalspares:
                                            service['TotalSpares'] ?? [],
                                        totalsparesmrp:
                                            service['TotalSparesMRP'] ?? 0)),
                              ),
                              child: ServiceCommonListContainer(
                                title: service['Title'],
                                productId: serviceId,
                                categoryId: '5AMC',
                                categoryName: 'AMC',
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
