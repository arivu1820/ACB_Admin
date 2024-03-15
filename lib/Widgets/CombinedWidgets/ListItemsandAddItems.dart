import 'package:acb_admin/Screens/AddProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/CommonListContioner.dart';
import 'package:flutter/widgets.dart';

class ListItemsandAddItems extends StatelessWidget {
  final String category;

  const ListItemsandAddItems({
    Key? key,
    required this.category,
  }) : super(key: key);

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
                    '$category',
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
                    MaterialPageRoute(
                        builder: (context) => AddProductScreen()),
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
          Container(
            margin: const EdgeInsets.only(top: 30),
            height: 500,
            child: ListView.builder(
              itemCount: 13,
              itemBuilder: (context, index) {
                if (index == 12) {
                  return Column(
                    children: [
                      CommonListContainer(
                        title:
                            "Voltas 183V Vectra Platina 4 in 1 Convertible 1.5 Ton 3 Star Inverter Split AC with Anti Dust Filter (2023 Model, Copper. Platina 4 in 1 Conv,Voltas 183V Vectra Platina 4 in 1 Convertible 1.5 Ton 3 Star Inverter Split AC with Anti Dust Filter (2023 Model, Copper. Platina 4 in 1 Conv",
                      ),
                      SizedBox(height: 30),
                    ],
                  );
                } else {
                  return CommonListContainer(
                    title:
                        "Voltas 183V Vectra Platina 4 in 1 Convertible 1.5 Ton 3 Star Inverter Split AC with Anti Dust Filter (2023 Model, Copper. Platina 4 in 1 Conv,Voltas 183V Vectra Platina 4 in 1 Convertible 1.5 Ton 3 Star Inverter Split AC with Anti Dust Filter (2023 Model, Copper. Platina 4 in 1 Conv",
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
