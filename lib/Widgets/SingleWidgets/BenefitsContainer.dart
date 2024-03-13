import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';

class BenefitsContainer extends StatelessWidget {
  const BenefitsContainer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: darkBlueColor)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Expanded(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '• ',
                      style: TextStyle(
                        color: darkBlueColor,
                        fontFamily: 'LexendLight',
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'jasd;ljasljfsdljasl;d',
                      style: TextStyle(
                        color: blackColor,
                        fontFamily: 'LexendLight',
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            itemCount: 5,
          ),
        ),
      ),
    );
  }
}
