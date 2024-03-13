import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMCSubContainer.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/OrdersContainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CompletedAMCSubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: whiteColor,
      body: ListView.builder(
        itemBuilder: (context, index) =>AMCSubContainer(
          
          iscompleted: true,
          serviceno: '4th Service',
            name: 'Perarivalan',
            number: '6382219393',
            address:
                'Plot No:32, Padhamavathy Street, Thirumalaia Nagar, Ramapuram, Chennai - 600089',
            date: DateTime.now(),
            orderid:
                '#adsfs4fdfsdfsdfsdfsdf8evfaefbjebfjesfjfsjfksjbfkjebjhvj'),
        itemCount: 13,
      ));
}
