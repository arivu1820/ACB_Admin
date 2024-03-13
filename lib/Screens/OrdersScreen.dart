import 'package:acb_admin/Screens/OrdersListScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/OrdersContainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: whiteColor,
        body: ListView.builder(
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrdersListScreen(
                        address:
                            'Plot No:32, Padhamavathy Street, Thirumalaia Nagar, Ramapuram, Chennai - 600089',
                        date: DateTime.now(),
                        email: 'arivu1820@gmail.com',
                        name: 'Perarivalan',
                        number: '6382219393',
                        uid: 'jhaskldjfaskdfsajdfhlskdjhfklsdhfkdkjflkdsjfkldjlkfjlsdjhfklsdhfs',
                        onprocess: false,
                        orderid:
                            'kkjasd;ljas;dlfjsad;lfjasd;lfjsad;lfjas;ldfjasd;lfjasd;lfja;dslfj;saldfjas;ldfjsald',
                      )),
            ),
            child: OrdersContainer(
              name: 'Perarivalan',
              number: '6382219393',
              address:
                  'Plot No:32, Padhamavathy Street, Thirumalaia Nagar, Ramapuram, Chennai - 600089',
              date: DateTime.now(),
              orderid:
                  '#adsfs4fdfsdfsdfsdfsdf8evfaefbjebfjesfjfsjfksjbfkjebjhvj',
            ),
          ),
          itemCount: 13,
        ),
      );
}
