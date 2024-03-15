import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';

class ProductsCategoryListContainer extends StatelessWidget {
  final String title;

  const ProductsCategoryListContainer({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox( // Use SizedBox instead of Expanded
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
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontFamily: 'LexendRegular',fontSize: 20,color: blackColor),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Image.asset(
                'Assets/Close_Cross_Icon.png',
                width: 30,
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
