import 'dart:typed_data';

import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/SingleImageUploadContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class ServiceEditandSubmitforImage extends StatefulWidget {
  final String bannerurl;
  final String serviceId;
  ServiceEditandSubmitforImage({super.key, required this.bannerurl,required this.serviceId});

  @override
  State<ServiceEditandSubmitforImage> createState() =>
      _ServiceEditandSubmitforImageState();
}

class _ServiceEditandSubmitforImageState
    extends State<ServiceEditandSubmitforImage> {
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

          final imageUrl = await _uploadImage();

          if (widget.serviceId.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection('Services')
                .doc('hWHRjpawA5D6OTbrjn3h')
                .set({
              'BannerUrl': imageUrl ?? widget.bannerurl,
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Changes added successfully.'),
              ),
            );
            Navigator.of(context).pop();
          } else if (imageUrl != null) {
            await FirebaseFirestore.instance
                .collection('Services')
                .doc('hWHRjpawA5D6OTbrjn3h')
                .set({
              'BannerUrl': imageUrl,
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Banner Image added successfully.'),
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
    if (_imageBytes == null && widget.bannerurl.isNotEmpty) {
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
          .child('Images/Services')
          .child('ServicesBannerUrl.jpg');
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
    return Column(
      children: [
        EditandSumbitBtn(
          onEditPressed: _handleEditPressed,
          onSubmitPressed: _handleSubmitPressed,
        ),
        SingleImageUploadContainer(
          img: widget.bannerurl,
          isedit: isEditing,
          name: 'Image',
          onImageSelected: (Uint8List? image) {
            setState(() {
              _imageBytes = image;
            });
          },
        ),
      ],
    );
  }
}
