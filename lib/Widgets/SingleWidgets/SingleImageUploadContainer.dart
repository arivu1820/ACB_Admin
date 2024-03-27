import 'dart:io';
import 'dart:typed_data';

import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SingleImageUploadContainer extends StatefulWidget {
  final String name;
  final bool isedit;
  final String img;
  final Function(Uint8List?) onImageSelected;

  const SingleImageUploadContainer({
    Key? key,
    required this.name,
    this.img = '',
    this.isedit = false,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  _SingleImageUploadContainerState createState() =>
      _SingleImageUploadContainerState();
}

class _SingleImageUploadContainerState
    extends State<SingleImageUploadContainer> {
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
      widget.onImageSelected(_imageBytes); // Pass the selected image bytes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Column(
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
                    onTap: widget.isedit ? () => _pickImage(context) : () {},
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
                            : Image.asset('Assets/upload.png',width: 50,height: 50,),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
