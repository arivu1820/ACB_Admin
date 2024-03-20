import 'dart:typed_data';

import 'package:acb_admin/Models/FirebaseService.dart';
import 'package:acb_admin/Screens/CommonServicesScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/ListItemsandAddItems.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/ServicesListItemsandAddItems.dart';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/SingleImageUploadContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:acb_admin/Widgets/SingleWidgets/TextListContainer.dart';
import 'package:flutter/material.dart';

class WetWashScreen extends StatefulWidget {
  final String title;
  final String docId;
  final String img;
  WetWashScreen(
      {super.key, required this.docId, required this.img, required this.title});

  @override
  State<WetWashScreen> createState() => _WetWashScreenState();
}

class _WetWashScreenState extends State<WetWashScreen> {
  final TextEditingController ServiceNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ServiceNameController.text = widget.title;
  }

  bool isEditing = false;
  Uint8List? _imageBytes;

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
      if (_formKey.currentState!.validate()) {
        try {
          String name = ServiceNameController.text;

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );

          final imageUrl = await _uploadImage();

          if (widget.docId.isNotEmpty && widget.img.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection('Services')
                .doc('hWHRjpawA5D6OTbrjn3h')
                .collection('Categories')
                .doc('2WetWash')
                .set({
              'Image': imageUrl ?? widget.img,
              'ServiceName': name,
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Changes added successfully.'),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else if (imageUrl != null) {
            await FirebaseFirestore.instance
                .collection('Services')
                .doc('hWHRjpawA5D6OTbrjn3h')
                .collection('Categories')
                .doc('2WetWash')
                .set({
              'Image': imageUrl,
              'ServiceName': name,
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Image added successfully.'),
              ),
            );
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to upload image.'),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
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
  }

  Future<String?> _uploadImage() async {
    if (_imageBytes == null && widget.img.isNotEmpty) {
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
          .child('Images/Services/Wet Wash')
          .child('${ServiceNameController.text}.jpg');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            EditandSumbitBtn(
              onEditPressed: _handleEditPressed,
              onSubmitPressed: _handleSubmitPressed,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextContainer(
                    controller: ServiceNameController,
                    label: "Service Name",
                    limit: 50,
                    isnum: false,
                    isedit: isEditing,
                  ),
                  SingleImageUploadContainer(
                    img: widget.img,
                    isedit: isEditing,
                    name: 'Image',
                    onImageSelected: (Uint8List? image) {
                      setState(() {
                        _imageBytes = image;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.docId.isNotEmpty
                      ? ServicesListItemsandAddItems(
                          category: "Services",
                          name: widget.docId.isNotEmpty
                              ? widget.title
                              : "Category",
                          categoryId: widget.docId,
                          categoryName: 'WetWash',
                          screen: CommonServicesScreen(categoryId: widget.docId, servicename: 'WetWash',iswetwash: true,),
                          ServiceQuerySnapshot: FirebaseService().getWetWash(),
                        
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
