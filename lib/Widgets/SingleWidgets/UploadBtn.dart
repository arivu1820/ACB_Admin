import 'dart:typed_data';

import 'package:acb_admin/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadBtn extends StatefulWidget {
  Uint8List? imageBytes;
  String uid, orderid;

  UploadBtn(
      {super.key,
      required this.imageBytes,
      required this.orderid,
      required this.uid});

  @override
  State<UploadBtn> createState() => _UploadBtnState();
}

class _UploadBtnState extends State<UploadBtn> {
  @override
  Widget build(BuildContext context) {
    bool issubmited = false;

    Future<String?> _uploadImage() async {
      setState(() {
        issubmited = true;
      });
      if (widget.imageBytes == null) {
        return null;
      }

      if (widget.imageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an image first.'),
          ),
        );
        setState(() {
          issubmited = false;
        });
        return null;
      }

      try {
        final firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('Images/AMCSub/${widget.uid}')
            .child('${widget.orderid}.jpg');
        await ref.putData(widget.imageBytes!);
        final imageUrl = await ref.getDownloadURL();
        setState(() {
          issubmited = false;
        });
        return imageUrl;
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading image: $error'),
          ),
        );
        print("$error");
        setState(() {
          issubmited = false;
        });
        return null;
      }
    }

    return GestureDetector(
      onTap: widget.imageBytes == null
          ? () {}
          : () async {
            
              final imageUrl = await _uploadImage();

              if (imageUrl != null) {
                FirebaseFirestore.instance
                    .collection('CurrentAMCSubscription')
                    .doc(widget.orderid)
                    .update({
                  'Image': imageUrl,
                }).then((_) {
                  // Image update successful
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Image updated successfully.'),
                    ),
                  );
                }).catchError((error) {
                  // Image update failed
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to update image: $error'),
                    ),
                  );
                });
              }
          
            },
      child: issubmited
          ? const Center(
              child: CircularProgressIndicator(
                color: darkBlueColor,
                strokeWidth: 2,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: darkBlueColor),
              height: 50,
              width: 140,
              child: const Center(
                  child: Text('Upload',
                      style: TextStyle(
                        color: whiteColor,
                        fontFamily: 'LexendRegular',
                        fontSize: 20,
                      ))),
            ),
    );
  }
}
