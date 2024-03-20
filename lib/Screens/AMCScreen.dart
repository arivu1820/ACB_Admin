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

class AMCScreen extends StatefulWidget {
  final String title;
  final String docId;
  final String bannerimg;
  final String splitImg;
  final String windowimg;
  final String cassetteimg;
  AMCScreen(
      {super.key,
      required this.docId,
      required this.title,
      required this.bannerimg,
      required this.splitImg,
      required this.windowimg,
      required this.cassetteimg});

  @override
  State<AMCScreen> createState() => _AMCScreenState();
}

class _AMCScreenState extends State<AMCScreen> {
  final TextEditingController ServiceNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ServiceNameController.text = widget.title;
  }

  bool isEditing = false;
  Uint8List? _BannerimageBytes;
  Uint8List? _splitacimageBytes;
  Uint8List? _windowacimageBytes;
  Uint8List? _cassetteacimageBytes;

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

          final bannerimageUrl = await _banneruploadImage();
          final splitacimageUrl = await _splituploadImage();
          final windowimageUrl = await _windowuploadImage();
          final cassetteimageUrl = await _cassetteuploadImage();

          if (widget.docId.isNotEmpty && widget.bannerimg.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection('Services')
                .doc('hWHRjpawA5D6OTbrjn3h')
                .collection('Categories')
                .doc('5AMC')
                .set({
              'BannerUrl': bannerimageUrl ?? widget.bannerimg,
              'SplitACIMG': splitacimageUrl ?? widget.splitImg,
              'WindowACIMG': windowimageUrl ?? widget.windowimg,
              'CassetteACIMG': cassetteimageUrl ?? widget.cassetteimg,
              'ServiceName': name,
              'Image': ''
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Changes added successfully.'),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else if (bannerimageUrl != null &&
              splitacimageUrl != null &&
              windowimageUrl != null &&
              cassetteimageUrl != null) {
            await FirebaseFirestore.instance
                .collection('Services')
                .doc('hWHRjpawA5D6OTbrjn3h')
                .collection('Categories')
                .doc('5AMC')
                .set({
              'BannerUrl': bannerimageUrl,
              'SplitACIMG': splitacimageUrl,
              'WindowACIMG': windowimageUrl,
              'CassetteACIMG': cassetteimageUrl,
              'ServiceName': name,
              'Image': ''
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

  Future<String?> _banneruploadImage() async {
    if (_BannerimageBytes == null && widget.bannerimg.isNotEmpty) {
      return null;
    }

    if (_BannerimageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an Banner Image'),
        ),
      );
      return null;
    }

    try {
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Images/Services/AMC')
          .child('AMCBannerImage.jpg');
      await ref.putData(_BannerimageBytes!);
      final imageUrl = await ref.getDownloadURL();

      return imageUrl;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading Banner image: $error'),
        ),
      );
      print("$error");
      return null;
    }
  }

  Future<String?> _splituploadImage() async {
    if (_splitacimageBytes == null && widget.splitImg.isNotEmpty) {
      return null;
    }

    if (_splitacimageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an Split AC Image'),
        ),
      );
      return null;
    }

    try {
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Images/Services/AMC')
          .child('AMCSplitAC.jpg');
      await ref.putData(_splitacimageBytes!);
      final imageUrl = await ref.getDownloadURL();

      return imageUrl;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading Split AC image: $error'),
        ),
      );
      print("$error");
      return null;
    }
  }

  Future<String?> _windowuploadImage() async {
    if (_windowacimageBytes == null && widget.windowimg.isNotEmpty) {
      return null;
    }

    if (_windowacimageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an Window AC Image'),
        ),
      );
      return null;
    }

    try {
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Images/Services/AMC')
          .child('AMCWindowAC.jpg');
      await ref.putData(_windowacimageBytes!);
      final imageUrl = await ref.getDownloadURL();

      return imageUrl;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading Window AC image: $error'),
        ),
      );
      print("$error");
      return null;
    }
  }

  Future<String?> _cassetteuploadImage() async {
    if (_cassetteacimageBytes == null && widget.cassetteimg.isNotEmpty) {
      return null;
    }

    if (_cassetteacimageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an Cassette AC Image'),
        ),
      );
      return null;
    }

    try {
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Images/Services/AMC')
          .child('AMCCassetteAC.jpg');
      await ref.putData(_cassetteacimageBytes!);
      final imageUrl = await ref.getDownloadURL();

      return imageUrl;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading Cassette AC image: $error'),
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
                    img: widget.bannerimg,
                    isedit: isEditing,
                    name: 'Banner Image',
                    onImageSelected: (Uint8List? image) {
                      setState(() {
                        _BannerimageBytes = image;
                      });
                    },
                  ),
                  SingleImageUploadContainer(
                    img: widget.splitImg,
                    isedit: isEditing,
                    name: 'Split AC',
                    onImageSelected: (Uint8List? image) {
                      setState(() {
                        _splitacimageBytes = image;
                      });
                    },
                  ),
                  SingleImageUploadContainer(
                    img: widget.windowimg,
                    isedit: isEditing,
                    name: 'Window AC',
                    onImageSelected: (Uint8List? image) {
                      setState(() {
                        _windowacimageBytes = image;
                      });
                    },
                  ),
                  SingleImageUploadContainer(
                    img: widget.cassetteimg,
                    isedit: isEditing,
                    name: 'Cassette AC',
                    onImageSelected: (Uint8List? image) {
                      setState(() {
                        _cassetteacimageBytes = image;
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
                          categoryName: 'GeneralService',
                          screen: CommonServicesScreen(
                              categoryId: widget.docId,
                              servicename: 'GeneralService'),
                          ServiceQuerySnapshot:
                              FirebaseService().getGeneralServices(),
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
