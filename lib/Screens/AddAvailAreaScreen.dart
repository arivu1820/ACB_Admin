import 'dart:io';
import 'dart:typed_data';
import 'package:acb_admin/Widgets/SingleWidgets/Appbar.dart';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/SingleImageUploadContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextContainer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAvailAreasScreen extends StatefulWidget {
  final String area;

  final String productId;
  AddAvailAreasScreen({Key? key, this.productId = '', this.area = ''})
      : super(key: key);

  @override
  State<AddAvailAreasScreen> createState() => _AddGeneralProductsScreenState();
}

class _AddGeneralProductsScreenState extends State<AddAvailAreasScreen> {
  final TextEditingController _areaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _areaController.text = widget.area;
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
          String area = _areaController.text;

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );

          if (widget.productId.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection('AvailableArea')
                .doc(widget.productId)
                .set({
              'pincode': area,
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Changes added successfully.'),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else {
            await FirebaseFirestore.instance.collection('AvailableArea').add({
              'pincode': area,
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('New pincode added successfully.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    controller: _areaController,
                    label: "Pincode",
                    limit: 6,
                    isnum: false,
                    minCharacters: 6,
                    isedit: isEditing,
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
