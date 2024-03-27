import 'dart:typed_data';

import 'package:acb_admin/Models/FirebaseService.dart';
import 'package:acb_admin/Widgets/SingleWidgets/Appbar.dart';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/SingleImageUploadContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class BannersScreen extends StatefulWidget {
   BannersScreen({Key? key}) : super(key: key);

  @override
  State<BannersScreen> createState() => _BannersScreenState();
}

class _BannersScreenState extends State<BannersScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  bool isEditing = false;
  Uint8List? _imageBytes;
  Uint8List? _CartimageBytes;

  void _handleEditPressed() {
    setState(() {
      isEditing = true;
    });
  }

  Future<void> _handleSubmitPressed() async {
    if (isEditing) {
      setState(() {
        isEditing = false;
      });

      if (_imageBytes == null && _CartimageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an image first,'),
          ),
        );
        return; // Exit the method if no image is selected
      }

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        bool flag = false;

        if (_imageBytes != null) {
          final imageUrl = await _uploadImage();

          // Handle uploading image URL to database
          await FirebaseFirestore.instance
              .collection('BannerImages')
              .doc('HomePageBanner')
              .set({
            'Image': imageUrl,
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Changes added successfully.'),
            ),
          );
          Navigator.of(context).pop();
          flag = true;
        }
        if (_CartimageBytes != null) {
          final imageUrl = await _cartuploadImage();

          // Handle uploading image URL to database
          await FirebaseFirestore.instance
              .collection('BannerImages')
              .doc('CartPageBanner')
              .set({
            'Image': imageUrl,
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Changes added successfully.'),
            ),
          );
          if (!flag) {Navigator.of(context).pop();}
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add, Try after sometime!'),
          ),
        );
        print('Error parsing data: $error');
      }
    }
  }

   Future<String?> _uploadImage() async {
    if (_imageBytes == null) {
      return null;
    }

    if (_imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image first.'),
        ),
      );
      return null;
    }

    try {
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Images/Banners')
          .child('HomePageBanner.jpg');
      await ref.putData(_imageBytes!);
      final imageUrl = await ref.getDownloadURL();

      return imageUrl;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading image: $error'),
        ),
      );
      print("$error");
      return null;
    }
  }

  Future<String?> _cartuploadImage() async {
    if (_CartimageBytes == null) {
      return null;
    }

    if (_CartimageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image first.'),
        ),
      );
      return null;
    }

    try {
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Images/Banners')
          .child('CartPageBanner.jpg');
      await ref.putData(_CartimageBytes!);
      final imageUrl = await ref.getDownloadURL();

      return imageUrl;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading image: $error'),
        ),
      );
      print("$error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          EditandSumbitBtn(
            onEditPressed: _handleEditPressed,
            onSubmitPressed: _handleSubmitPressed,
          ),
          StreamBuilder<DocumentSnapshot>(
            stream: _firebaseService.getHomepageBanner(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                if (!snapshot.hasData || snapshot.data!.data() == null) {
                  return Center(child: Text('No data available'));
                }
                final bannerData =
                    snapshot.data!.data()! as Map<String, dynamic>;
                final imageUrl = bannerData['Image'] as String;

                return Column(
                  children: [
                    SingleImageUploadContainer(
                      img: imageUrl, // Use imageUrl here instead of widget.img
                      isedit:
                          isEditing, // Assuming isEditing is a boolean variable that you want to set to true
                      name:
                          'HomePage Banner', // Give a different name for each image container
                      onImageSelected: (Uint8List? image) {
                        _imageBytes = image;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              }
            },
          ),
          StreamBuilder<DocumentSnapshot>(
            stream: _firebaseService.getCartpageBanner(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                if (!snapshot.hasData || snapshot.data!.data() == null) {
                  return Center(child: Text('No data available'));
                }
                final bannerData =
                    snapshot.data!.data()! as Map<String, dynamic>;
                final CartimageUrl = bannerData['Image'] as String;

                return Column(
                  children: [
                    SingleImageUploadContainer(
                      img:
                          CartimageUrl, // Use imageUrl here instead of widget.img
                      isedit:
                          isEditing, // Assuming isEditing is a boolean variable that you want to set to true
                      name:
                          'CartPage Banner', // Give a different name for each image container
                      onImageSelected: (Uint8List? image) {
                        _CartimageBytes = image;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
