import 'dart:typed_data';

import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextListContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/UploadImageListContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddAMCSchemeScreen extends StatefulWidget {
  final List<dynamic> benefits;
  final List<dynamic> imgs;
  final num mrp;
  final num discount;
  final String docId;
  final String title;
  final String overviewcontent;
  final List<dynamic> totalspares;
  final num totalsparesmrp;
  AddAMCSchemeScreen(
      {super.key,
      required this.benefits,
      required this.discount,
      required this.imgs,
      required this.docId,
      required this.mrp,
      required this.overviewcontent,
      required this.title,
      required this.totalspares,
      required this.totalsparesmrp});

  @override
  State<AddAMCSchemeScreen> createState() => _AddAMCSchemeScreenState();
}

class _AddAMCSchemeScreenState extends State<AddAMCSchemeScreen> {
  final TextEditingController NameController = TextEditingController();

  final TextEditingController MRPController = TextEditingController();

  final TextEditingController DiscountController = TextEditingController();

  final TextEditingController BenefitsController = TextEditingController();

  final TextEditingController DescriptionController = TextEditingController();

  final TextEditingController TotalSparesBenefitsController =
      TextEditingController();

  final TextEditingController TotalSparesMRPController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<dynamic> listedbenefits = [];
  List<dynamic> listedtotalspares = [];
  List<Uint8List> _selectedImages = [];
  List<dynamic> fetchedimageslist = []; // List to hold selected images
  List<dynamic> selectedimageslist = []; // List to hold selected images
  List<dynamic> removedimageslist = [];

  @override
  void initState() {
    super.initState();
    NameController.text = widget.title;
    DescriptionController.text = widget.overviewcontent;
    MRPController.text = widget.mrp.toString();
    DiscountController.text = widget.discount.toString();
    TotalSparesMRPController.text = widget.totalsparesmrp.toString();
    listedbenefits = widget.benefits;
    listedtotalspares = widget.totalspares;
    fetchedimageslist = widget.imgs;
  }

  bool isEditing = false;

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
          String name = NameController.text;
          String description = DescriptionController.text;
          int mrp = int.parse(MRPController.text);
          int discount = int.parse(DiscountController.text);
          int totalsparesprice = int.parse(TotalSparesMRPController.text);

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );

          if (removedimageslist.isNotEmpty) {
            // Remove items from fetchedimageslist based on the values in removedimageslist
            fetchedimageslist
                .removeWhere((item) => removedimageslist.contains(item));
          }

          // Upload images and get download URLs
          for (Uint8List imageBytes in _selectedImages) {
            String? imageUrl = await _uploadImage(imageBytes);
            if (imageUrl != null) {
              selectedimageslist.add(imageUrl);
            }
          }

          if (listedbenefits.isEmpty || listedtotalspares.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Scheme Benefits and Total Spares Benefits Should be Empty'),
              ),
            );
            Navigator.of(context).pop();

            return;
          }

          // if (listedbenefits.length != fetchedimageslist.length+selectedimageslist.length) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text(
          //           'Scheme Benefits and Images length should be same!'),
          //     ),
          //   );
          //   Navigator.of(context).pop();

          //   return;
          // }

          if (fetchedimageslist.isEmpty && selectedimageslist.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Images should not be Empty'),
              ),
            );
            Navigator.of(context).pop();

            return;
          }

          Map<String, dynamic> contentData = {
            'Title': name,
            'Discount': discount,
            'MRP': mrp,
            "TotalSparesMRP": totalsparesprice,
            'TotalSpares': listedtotalspares,
            "Benefits": listedbenefits,
            'OverviewContent': description,
            'Images': [
              ...fetchedimageslist,
              ...selectedimageslist,
            ], // Store image URLs in the database
          };

          if (widget.docId.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection('Services')
                .doc('hWHRjpawA5D6OTbrjn3h')
                .collection('Categories')
                .doc('5AMC')
                .collection('AMC')
                .doc(widget.docId)
                .set({
              'Content': contentData,
              // Store image URLs in the database
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Changes added successfully.'),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else if (widget.docId.isEmpty) {
            await FirebaseFirestore.instance
                .collection('Services')
                .doc('hWHRjpawA5D6OTbrjn3h')
                .collection('Categories')
                .doc('5AMC')
                .collection('AMC')
                .add({
              'Content': contentData,
// Store image URLs in the database
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('New Scheme added successfully.'),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to add'),
              ),
            );
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

  Future<String?> _uploadImage(Uint8List imageBytes) async {
    try {
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('Images/Services/AMC')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putData(imageBytes);
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
                    controller: NameController,
                    label: "Scheme Name",
                    limit: 500,
                    isnum: false,
                    isedit: isEditing,
                  ),
                  TextContainer(
                    controller: DescriptionController,
                    label: "Description",
                    limit: 100,
                    isnum: false,
                    isedit: isEditing,
                  ),
                  TextContainer(
                    controller: MRPController,
                    label: "MRP",
                    limit: 10,
                    isnum: true,
                    isedit: isEditing,
                  ),
                  TextContainer(
                    controller: DiscountController,
                    label: "Discount",
                    limit: 3,
                    isnum: true,
                    isedit: isEditing,
                  ),
                  TextListContainer(
                    controller: BenefitsController,
                    label: "Benefits",
                    limit: 200,
                    isnum: false,
                    isedit: isEditing,
                    fetchedlist: listedbenefits,
                    onTextListChanged: (List<String> list) {
                      setState(() {
                        listedbenefits = list;
                      });
                    },
                  ),
                  UploadImageListContainer(
                    imgs: widget.imgs,
                    name: 'Upload Images',
                    isedit: isEditing,
                    selectedImages: _selectedImages,
                    onImagesSelected: (List<Uint8List> images) {
                      setState(() {
                        _selectedImages = images;
                      });
                    },
                    onfetchedImagesremoved: (List<dynamic> removedimages) {
                      setState(() {
                        removedimageslist = removedimages;
                      });
                    },
                  ),
                  TextContainer(
                    controller: TotalSparesMRPController,
                    label: "TotalSpares MRP",
                    limit: 10,
                    isnum: true,
                    isedit: isEditing,
                  ),
                  TextListContainer(
                    controller: TotalSparesBenefitsController,
                    label: "TotalSpares Benefits",
                    limit: 100,
                    isnum: false,
                    isedit: isEditing,
                    fetchedlist: listedtotalspares,
                    onTextListChanged: (List<String> list) {
                      setState(() {
                        listedtotalspares = list;
                      });
                    },
                  ),
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
