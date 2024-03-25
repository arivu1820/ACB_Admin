import 'dart:convert';
import 'dart:js_util';
import 'dart:typed_data';

import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextListContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextMapContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/UploadImageListContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  final String name;
  final String brand;
  final String ton;
  final num discount;
  final num mrp;
  final List<dynamic> overview;
  final num stock;
  final Map<String, dynamic> Specification;
  final String categoryId;
  final String docId;
  final List<dynamic> imgs;

  AddProductScreen(
      {super.key,
      this.brand = '',
      this.discount = 0,
      this.mrp = 0,
      required this.categoryId,
      this.docId = "",
      this.name = '',
      this.imgs = const [],
      this.Specification = const {},
      this.overview = const [],
      this.stock = 0,
      this.ton = ''});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController NameController = TextEditingController();

  final TextEditingController MRPController = TextEditingController();

  final TextEditingController DiscountController = TextEditingController();

  final TextEditingController StockController = TextEditingController();

  final TextEditingController TonController = TextEditingController();

  final TextEditingController BrandController = TextEditingController();

  final TextEditingController OverviewController = TextEditingController();

  final TextEditingController SpecificationkeyController =
      TextEditingController();

  final TextEditingController SpecificationvalueController =
      TextEditingController();

  List<dynamic> listedoverview = [];
  Map<String, dynamic> mapspecification = {};
  List<Uint8List> _selectedImages = [];
  List<dynamic> fetchedimageslist = []; // List to hold selected images
  List<dynamic> selectedimageslist = []; // List to hold selected images
  List<dynamic> removedimageslist = [];

  @override
  void initState() {
    super.initState();
    NameController.text = widget.name;
    BrandController.text = widget.brand;
    DiscountController.text = widget.discount.toString();
    MRPController.text = widget.mrp.toString();
    listedoverview = widget.overview;
    StockController.text = widget.stock.toString();
    TonController.text = widget.ton;
    mapspecification = widget.Specification;
    fetchedimageslist = widget.imgs;
    //  fetchedimageslist.addAll(widget.imgs);

    // _selectedImages = List<Uint8List>.from(widget.imgs.cast<Uint8List>());
  }

  final _formKey = GlobalKey<FormState>();

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
          int mrp = int.parse(MRPController.text);
          int discount = int.parse(DiscountController.text);
          int stock = int.parse(StockController.text);
          String ton = TonController.text;
          String brand = BrandController.text;

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

          if (listedoverview.isEmpty || mapspecification.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Overview and Specification Should be Empty'),
              ),
            );
            Navigator.of(context).pop();

            return;
          }

          if (fetchedimageslist.isEmpty && selectedimageslist.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Images should not be Empty'),
              ),
            );
            Navigator.of(context).pop();

            return;
          }

          if (widget.docId.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection('Categories')
                .doc(widget.categoryId)
                .collection("Products")
                .doc(widget.docId)
                .set({
              'Name': name,
              'Discount': discount,
              'MRP': mrp,
              "Stock": stock,
              'Brand': brand,
              'Ton': ton,
              "Overview": listedoverview,
              "Specification": mapspecification,
              'Images': [
                ...fetchedimageslist,
                ...selectedimageslist,
              ], // Store image URLs in the database
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
                .collection('Categories')
                .doc(widget.categoryId)
                .collection("Products")
                .add({
              'Name': name,
              'Discount': discount,
              'MRP': mrp,
              "Stock": stock,
              'Brand': brand,
              'Ton': ton,
              "Specification": mapspecification,
              "Overview": listedoverview,
              'Images': [
                ...fetchedimageslist,
                ...selectedimageslist,
              ], // Store image URLs in the database
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('New Category added successfully.'),
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
          .child('Images/GeneralProducts')
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
                    label: "Name",
                    limit: 500,
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
                  TextContainer(
                    controller: StockController,
                    label: "Stock",
                    limit: 3,
                    isnum: true,
                    isedit: isEditing,
                  ),
                  TextContainer(
                    controller: TonController,
                    label: "Ton",
                    limit: 50,
                    isnum: false,
                    isedit: isEditing,
                  ),
                  TextContainer(
                    controller: BrandController,
                    label: "Brand",
                    limit: 50,
                    isnum: false,
                    isedit: isEditing,
                  ),
                  TextListContainer(
                    controller: OverviewController,
                    label: "Overview",
                    limit: 400,
                    isnum: false,
                    isedit: isEditing,
                    fetchedlist: listedoverview,
                    onTextListChanged: (List<String> list) {
                      setState(() {
                        listedoverview = list;
                      });
                    },
                  ),
                  TextMapContainer(
                    limit: 25,
                    isnum: false,
                    firstcontroller: SpecificationkeyController,
                    secondcontroller: SpecificationvalueController,
                    fetchedmap: mapspecification,
                    isedit: isEditing,
                    label: 'Specification',
                    onTextmapChanged: (Map<String, dynamic> map) {
                      setState(() {
                        mapspecification = map;
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
