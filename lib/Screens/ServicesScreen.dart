import 'package:acb_admin/Models/FirebaseService.dart';
import 'package:acb_admin/Screens/AMCScreen.dart';
import 'package:acb_admin/Screens/GeneralServiceScreen.dart';
import 'package:acb_admin/Screens/InstallUninstallScreen.dart';
import 'package:acb_admin/Screens/RepairScreen.dart';
import 'package:acb_admin/Screens/WetWashScreen.dart';
import 'package:acb_admin/Temp/temp.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/ServiceEditandSubmitforImage.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/ServicesCategoryListContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/SingleImageUploadContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({super.key});
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: _firebaseService.getServicesBanner(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for data, show a progress indicator.
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // If an error occurs, display the error message.
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                // If data is successfully retrieved, extract the product data.
                final document = snapshot.data!;

                final services = snapshot.data!.data() as Map<String, dynamic>?;

                // Extract the field value and handle the case where it might not exist.
                String bannerUrl = services?['BannerUrl'] ??
                    ''; // If 'BannerUrl' doesn't exist, set bannerUrl as an empty string.
                String docId = document.id;

                return ServiceEditandSubmitforImage(
                  bannerurl: bannerUrl,
                  serviceId: docId,
                );
              }
            },
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
          StreamBuilder<DocumentSnapshot>(
            stream: _firebaseService.GeneralService(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for data, show a progress indicator.
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // If an error occurs, display the error message.
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                // If data is successfully retrieved, extract the product data.
                final document = snapshot.data!;

                final services = snapshot.data!.data() as Map<String, dynamic>?;

                // Extract the field value and handle the case where it might not exist.
                String Img = services?['Image'] ??
                    ''; // If 'BannerUrl' doesn't exist, set bannerUrl as an empty string.
                String docId = document.id;

                String ServiceName = services?['ServiceName'] ?? '';

                return ServicesCategoryListContainer(
                  title: ServiceName,
                  Screen: GeneralServiceScreen(
                    title: ServiceName,
                    img: Img,
                    docId: docId,
                  ),
                );
              }
            },
          ),
          StreamBuilder<DocumentSnapshot>(
            stream: _firebaseService.WetWash(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for data, show a progress indicator.
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // If an error occurs, display the error message.
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                // If data is successfully retrieved, extract the product data.
                final document = snapshot.data!;

                final services = snapshot.data!.data() as Map<String, dynamic>?;

                // Extract the field value and handle the case where it might not exist.
                String Img = services?['Image'] ??
                    ''; // If 'BannerUrl' doesn't exist, set bannerUrl as an empty string.
                String docId = document.id;

                String ServiceName = services?['ServiceName'] ?? '';

                return ServicesCategoryListContainer(
                  title: ServiceName,
                  Screen: WetWashScreen(
                    title: ServiceName,
                    img: Img,
                    docId: docId,
                  ),
                );
              }
            },
          ),

          StreamBuilder<DocumentSnapshot>(
            stream: _firebaseService.Repair(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for data, show a progress indicator.
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // If an error occurs, display the error message.
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                // If data is successfully retrieved, extract the product data.
                final document = snapshot.data!;

                final services = snapshot.data!.data() as Map<String, dynamic>?;

                // Extract the field value and handle the case where it might not exist.
                String Img = services?['Image'] ??
                    ''; // If 'BannerUrl' doesn't exist, set bannerUrl as an empty string.
                String docId = document.id;

                String ServiceName = services?['ServiceName'] ?? '';

                return ServicesCategoryListContainer(
                  title: ServiceName,
                  Screen: RepairScreen(
                    title: ServiceName,
                    img: Img,
                    docId: docId,
                  ),
                );
              }
            },
          ),

          StreamBuilder<DocumentSnapshot>(
            stream: _firebaseService.InstallUninstall(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for data, show a progress indicator.
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // If an error occurs, display the error message.
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                // If data is successfully retrieved, extract the product data.
                final document = snapshot.data!;

                final services = snapshot.data!.data() as Map<String, dynamic>?;

                // Extract the field value and handle the case where it might not exist.
                String Img = services?['Image'] ??
                    ''; // If 'BannerUrl' doesn't exist, set bannerUrl as an empty string.
                String docId = document.id;

                String ServiceName = services?['ServiceName'] ?? '';

                return ServicesCategoryListContainer(
                  title: ServiceName,
                  Screen: InstallUninstallScreen(
                    title: ServiceName,
                    img: Img,
                    docId: docId,
                  ),
                );
              }
            },
          ),

          // ServicesCategoryListContainer(
          //   title: 'Wet Wash',
          //   Screen: WetWashScreen(),
          // ),
          // ServicesCategoryListContainer(
          //   title: 'Repair',
          //   Screen: RepairScreen(),
          // ),
          // ServicesCategoryListContainer(
          //   title: 'Install Uninstall',
          //   Screen: InstallUninstallScreen(),
          // ),
          StreamBuilder<DocumentSnapshot>(
            stream: _firebaseService.AMC(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for data, show a progress indicator.
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // If an error occurs, display the error message.
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                // If data is successfully retrieved, extract the product data.
                final document = snapshot.data!;

                final services = snapshot.data!.data() as Map<String, dynamic>?;

                // Extract the field value and handle the case where it might not exist.
                String bannerImg = services?['BannerUrl'] ??
                    ''; // If 'BannerUrl' doesn't exist, set bannerUrl as an empty string.
                String docId = document.id;

                String ServiceName = services?['ServiceName'] ?? '';
                String splitImg = services?['SplitACIMG'] ?? '';
                String windowImg = services?['WindowACIMG'] ?? '';
                String cassetteImg = services?['CassetteACIMG'] ?? '';

                return ServicesCategoryListContainer(
                    title: ServiceName,
                    Screen: AMCScreen(
                        docId: docId,
                        title: ServiceName,
                        bannerimg: bannerImg,
                        splitImg: splitImg,
                        windowimg: windowImg,
                        cassetteimg: cassetteImg));
              }
            },
          ),
        ],
      ),
    );
  }
}
