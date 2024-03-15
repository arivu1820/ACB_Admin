import 'package:acb_admin/Models/NavItem.dart';
import 'package:acb_admin/Screens/AMCSubScreen.dart';
import 'package:acb_admin/Screens/CompletedAMCSubScreen.dart';
import 'package:acb_admin/Screens/CompletedOrdersScreen.dart';
import 'package:acb_admin/Screens/GeneralProductsScreen.dart';
import 'package:acb_admin/Screens/OrdersScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<NavItem> navItems = [
    NavItem("Orders"),
    NavItem("AMC Subscription"),
    NavItem("General Products"),
    NavItem("Completed Orders"),
    NavItem("Completed AMC Subscription"),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: whiteColor,
                border: Border(
                  right: BorderSide(width: 2.0, color: darkBlueColor),
                ),
              ),
              width: 400,
              child: ListView.builder(
                itemCount: navItems.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
                  child: Container(
                    height: 110.0,
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      border: Border(
                        bottom: BorderSide(width: 2.0, color: darkBlueColor),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            navItems[index].title,
                            style: TextStyle(
                              fontFamily: 'LexendMedium',
                              fontSize: _currentPageIndex == index ? 32 : 24,
                              color: _currentPageIndex == index
                                  ? darkBlueColor
                                  : blackColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          "Assets/Arrowright.png",
                          width: 15.0,
                          height: 20.0,
                          color: _currentPageIndex == index
                              ? darkBlueColor
                              : blackColor,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) =>
                    setState(() => _currentPageIndex = index),
                children: [
                  OrdersScreen(),
                  AMCSubScreen(),
                  GeneralProductsScreen(),
                  CompletedOrdersScreen(),
                  CompletedAMCSubScreen(),
                ],
              ),
            ),
          ],
        ),
      );
}
