import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';

class OrdersListContainer extends StatelessWidget {
  const OrdersListContainer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'category',
            style: TextStyle(
              fontFamily: 'LexendMedium',
              fontSize: 32,
              color: blackColor,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'LG 1.5 Ton 5 Star DUAL Inverter Split AC (Copper, AI Convertible 6-in-1 Cooling, 4 Way, HD Filter with Anti-Virus Protection, 2024 Model, TS-Q19YNZE, White),,LG 1.5 Ton 5 Star DUAL Inverter Split AC (Copper, AI Convertible 6-in-1 Cooling, 4 Way, HD Filter with Anti-Virus Protection, 2024 Model, TS-Q19YNZE, White)',
                    style: TextStyle(
                      fontFamily: 'LexendRegular',
                      fontSize: 16,
                      color: blackColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Column(
                  children: [
                    Text(
                      '5,999',
                      style: TextStyle(
                        fontFamily: 'LexendRegular',
                        fontSize: 17,
                        color: blackColor,
                      ),
                    ),
                    Text(
                      'Qty: 1',
                      style: TextStyle(
                        fontFamily: 'LexendRegular',
                        fontSize: 12,
                        color: blackColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          itemCount: 3,
        )
      ],
    );
  }
}