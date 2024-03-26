import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/UploadBtn.dart';
import 'package:image_picker/image_picker.dart';

class AMCUploadContainer extends StatefulWidget {
  final String img, name, uid, orderid;
  final bool isedit;

  const AMCUploadContainer(
      {Key? key,
      required this.img,
      required this.name,
      required this.orderid,
      this.isedit = true,
      required this.uid});

  @override
  State<AMCUploadContainer> createState() => _AMCUploadContainerState();
}

class _AMCUploadContainerState extends State<AMCUploadContainer> {
  Uint8List? _imageBytes;

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery, // For selecting from gallery
      // You can also add ImageSource.camera to allow capturing from the camera
    );
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });

      // Pass the selected image bytes
    }
  }

  void vieworupload(BuildContext context, String orderid) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Image'),
          content: const Text(
              'If you want to view the image press view or if you like to upload the image press upload'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                _showImageDialog(context, widget.img);
              },
              child: Text('View'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                _pickImage(context);
              },
              child: Text('upload'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: const TextStyle(fontFamily: 'LexendRegular', fontSize: 20),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => vieworupload(context, widget.orderid),
                  child: _imageBytes != null
                      ? Image.memory(
                          _imageBytes!,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        )
                      : widget.img.isNotEmpty
                          ? Image.network(
                              widget.img,
                              width: 50,
                              height: 50,
                            )
                          : Icon(Icons.add_photo_alternate, size: 50),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Text(
                    'Tap to select an image',
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: 'LexendRegular',
                      fontSize: 20,
                    ),
                  ),
                ),
                UploadBtn(
                  imageBytes: _imageBytes,
                  uid: widget.uid,
                  orderid: widget.orderid,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showImageDialog(BuildContext context, String img) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.maxFinite,
            child: Image.network(
              img,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
