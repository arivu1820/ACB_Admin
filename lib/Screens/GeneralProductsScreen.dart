import 'package:acb_admin/Screens/AddGeneralProductsScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/OrdersContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/GeneralProductsListContainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GeneralProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: whiteColor,
      body: ListView.builder(
        itemBuilder: (context, index) => GestureDetector(
                   onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddGeneralProductsScreen()),),
          child: GeneralProductsListContainer(
              img:
                  'https://5.imimg.com/data5/UD/CD/UD/ANDROID-2577822/prod-20200725-2212247928036451076505197-jpg-500x500.jpg',
              title:
                  'Voltas 183V Vectra Platina 4 in 1 Convertible 1.5 Ton 3 Star Inverter Split AC with Anti Dust FilterVoltas 183V Vectra Platina 4 in 1 Convertible 1.5 Ton 3 Star Inverter Split AC with Anti Dust FilterVoltas 183V Vectra Platina 4 in 1 Convertible 1.5 Ton 3 Star Inverter Split AC with Anti Dust FilterVoltas 183V Vectra Platina 4 in 1 Convertible 1.5 Ton 3 Star Inverter Split AC with Anti Dust FilterVoltas 183V Vectra Platina 4 in 1 Convertible 1.5 Ton 3 Star Inverter Split AC with Anti Dust Filter (2023 Model, Copper. Platina 4 in 1 Conv,Voltas 183V Vectra Platina 4 in 1 Convertible 1.5 Ton 3 Star Inverter Split AC with Anti Dust Filter (2023 Model, Copper. Platina 4 in 1 Conv'),
        ),
        itemCount: 13,
      ));
}
