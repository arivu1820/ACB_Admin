import 'package:acb_admin/Models/DataBaseHelper.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonListContainer extends StatelessWidget {
  final String title;
  final String categoryId;
  final String productId;

  const CommonListContainer({
    Key? key,
    required this.title,
    required this.categoryId,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Use SizedBox instead of Expanded
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: darkBlue25Color,
              offset: Offset(0, 0),
              blurRadius: 4.0,
              spreadRadius: 3,
            ),
          ],
        ),
        constraints: BoxConstraints(minHeight: 100),
        margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'LexendRegular',
                    fontSize: 13,
                    color: blackColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () =>
                    DatabaseHelper.removeProduct(context, productId, categoryId),
                child: Image.asset(
                  'Assets/Close_Cross_Icon.png',
                  width: 30,
                  height: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
