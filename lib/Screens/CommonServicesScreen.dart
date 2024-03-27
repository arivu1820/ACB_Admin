import 'dart:typed_data';

import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/ListItemsandAddItems.dart';
import 'package:acb_admin/Widgets/SingleWidgets/Appbar.dart';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/SingleImageUploadContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextListContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextMapContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/UploadImageListContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class CommonServicesScreen extends StatefulWidget {
  final List<dynamic> benefits;
  final String img;
  final num mrp;
  final num discount;
  final String title;
  final String serviceId;
  final String servicename;
  final String categoryId;
  CommonServicesScreen(
      {super.key,
      this.benefits = const [],
      this.discount = 0,
      this.img = '',
      required this.categoryId,
      this.serviceId = '',
      required this.servicename,
      this.mrp = 0,
      this.title = ''});

  @override
  State<CommonServicesScreen> createState() => _CommonServicesScreenState();
}

class _CommonServicesScreenState extends State<CommonServicesScreen> {
  final TextEditingController NameController = TextEditingController();

  final TextEditingController MRPController = TextEditingController();

  final TextEditingController DiscountController = TextEditingController();

  final TextEditingController BenefitsController = TextEditingController();
  List<dynamic> listedbenefits = [];

  @override
  void initState() {
    super.initState();
    NameController.text = widget.title;
    listedbenefits = widget.benefits;
    MRPController.text = widget.mrp.toString();
    DiscountController.text = widget.discount.toString();
  }

  final _formKey = GlobalKey<FormState>();
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
          String name = NameController.text;
          int mrp = int.parse(MRPController.text);
          int discount = int.parse(DiscountController.text);
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

          if (listedbenefits.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Benefits Should be Empty'),
              ),
            );
            Navigator.of(context).pop();

            return;
          }

          if (widget.serviceId.isNotEmpty) {
              await FirebaseFirestore.instance
                  .collection('Services')
                  .doc('hWHRjpawA5D6OTbrjn3h')
                  .collection('Categories')
                  .doc(widget.categoryId)
                  .collection(widget.servicename)
                  .doc(widget.serviceId)
                  .set({
                'Title': name,
                'MRP': mrp,
                'Discount': discount,
                'Benefits': listedbenefits,
                'Image': imageUrl ?? widget.img,
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
                  .doc(widget.categoryId)
                  .collection(widget.servicename)
                  .add({
                'Title': name,
                'MRP': mrp,
                'Discount': discount,
                'Benefits': listedbenefits,
                'Image': imageUrl,
              });
          

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Service added successfully.'),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to upload image.'),
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
          .child('Images/Services/${widget.servicename}/')
          .child('${NameController.text}.jpg');
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
      appBar: AppBarWidget(),
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
                    label: "Name",
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
                    limit: 100,
                    isnum: false,
                    isedit: isEditing,
                    fetchedlist: listedbenefits,
                    onTextListChanged: (List<String> list) {
                      setState(() {
                        listedbenefits = list;
                      });
                    },
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
