import 'dart:io';
import 'dart:typed_data';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/SingleImageUploadContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextContainer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class AddGeneralProductsScreen extends StatefulWidget {
  final String name;
  final String img;
  final num stock;
  final num mrp;
  final num discount;
  final String productId;
  AddGeneralProductsScreen(
      {Key? key,
      this.discount = 0,
      this.img = '',
      this.mrp = 0,
      this.name = '',
      this.productId = '',
      this.stock = 0})
      : super(key: key);

  @override
  State<AddGeneralProductsScreen> createState() =>
      _AddGeneralProductsScreenState();
}

class _AddGeneralProductsScreenState extends State<AddGeneralProductsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mrpController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _mrpController.text = widget.mrp.toString();
    _discountController.text = widget.discount.toString();
    _stockController.text = widget.stock.toString();
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
          String name = _nameController.text;
          int mrp = int.parse(_mrpController.text);
          int discount = int.parse(_discountController.text);
          int stock = int.parse(_stockController.text);

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

          if (widget.productId.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection('GeneralProducts')
                .doc(widget.productId)
                .set({
              'Name': name,
              'MRP': mrp,
              'Discount': discount,
              'Stock': stock,
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
            await FirebaseFirestore.instance.collection('GeneralProducts').add({
              'Name': name,
              'MRP': mrp,
              'Discount': discount,
              'Stock': stock,
              'Image': imageUrl,
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('GeneralProduct added successfully.'),
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
          .child('Images/GeneralProducts')
          .child('${_nameController.text}.jpg');
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
      backgroundColor: Colors.white,
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
                    controller: _nameController,
                    label: "Name",
                    limit: 500,
                    isnum: false,
                    minCharacters: 1,
                    isedit: isEditing,
                  ),
                  TextContainer(
                    controller: _mrpController,
                    label: "MRP",
                    limit: 10,
                    isnum: true,
                    minCharacters: 1,
                    isedit: isEditing,
                  ),
                  TextContainer(
                    controller: _discountController,
                    label: "Discount",
                    limit: 3,
                    isnum: true,
                    minCharacters: 1,
                    isedit: isEditing,
                  ),
                  TextContainer(
                    controller: _stockController,
                    label: "Stock",
                    limit: 3,
                    isnum: true,
                    isedit: isEditing,
                    minCharacters: 1,
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
