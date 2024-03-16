import 'package:acb_admin/Screens/AMCScreen.dart';
import 'package:acb_admin/Screens/GeneralServiceScreen.dart';
import 'package:acb_admin/Screens/InstallUninstallScreen.dart';
import 'package:acb_admin/Screens/RepairScreen.dart';
import 'package:acb_admin/Screens/WetWashScreen.dart';
import 'package:acb_admin/Temp/temp.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/ServicesCategoryListContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/SingleImageUploadContainer.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          EditandSumbitBtn(),
          SingleImageUploadContainer(
            name: 'Banner Url',
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Services',
                style: TextStyle(
                    fontFamily: 'LexendRegular',
                    fontSize: 32,
                    color: blackColor),
              ),
              Spacer()
            ],
          ),
          ServicesCategoryListContainer(
            title: 'General Service',
            Screen: GeneralServiceScreen(),
          ),
          ServicesCategoryListContainer(
            title: 'Wet Wash',
            Screen: WetWashScreen(),
          ),
          ServicesCategoryListContainer(
            title: 'Repair',
            Screen: RepairScreen(),
          ),
          ServicesCategoryListContainer(
            title: 'Install Uninstall',
            Screen: InstallUninstallScreen(),
          ),
          ServicesCategoryListContainer(
            title: 'AMC',
            Screen: AMCScreen(),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
