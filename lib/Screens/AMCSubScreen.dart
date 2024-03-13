import 'package:acb_admin/Screens/AMCSubListScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/AMCSubContainer.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/OrdersContainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AMCSubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: whiteColor,
      body: ListView.builder(
        itemBuilder: (context, index) =>GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>AMCSubListScreen(
                    serviceno: '1st Service',
                        address:
                            'Plot No:32, Padhamavathy Street, Thirumalaia Nagar, Ramapuram, Chennai - 600089',
                        date: DateTime.now(),
                        email: 'arivu1820@gmail.com',
                        name: 'Perarivalan',
                        number: '6382219393',
                        uid: 'jhaskldjfaskdfsajdfhlskdjhfklsdhfkdkjflkdsjfkldjlkfjlsdjhfklsdhfs',
                        onprocess: true,
                        orderid:
                            'kkjasd;ljas;dlfjsad;lfjasd;lfjsad;lfjas;ldfjasd;lfjasd;lfja;dslfj;saldfjas;ldfjsald',
                      )),
            ),
          child: AMCSubContainer(
            // isclaimed: true,
            // onprocess: true,
            iscompleted: true,
            serviceno: '1st Service',
              name: 'Perarivalan',
              number: '6382219393',
              address:
                  'Plot No:32, Padhamavathy Street, Thirumalaia Nagar, Ramapuram, Chennai - 600089',
              date: DateTime.now(),
              orderid:
                  '#adsfs4fdfsdfsdfsdfsdf8evfaefbjebfjesfjfsjfksjbfkjebjhvj'),
        ),
        itemCount: 13,
      ));
}
