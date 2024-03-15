import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:flutter/widgets.dart';

class UploadImageListContainer extends StatefulWidget {
  final String label;

  UploadImageListContainer({required this.label});

  @override
  _UploadImageListContainerState createState() => _UploadImageListContainerState();
}

class _UploadImageListContainerState extends State<UploadImageListContainer> {
  List<File> imageList = []; // List to store uploaded images

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'], // Specify image file types
    );

    if (result != null) {
      setState(() {
        imageList.add(File(result.files.single.path!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: "LexendRegular",
              color: blackColor,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => _pickImage(),
            child: Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: lightBlueColor,
                    ),
                    child:const Center(
                      child: Text(
                        'Upload',
                        style: TextStyle(
                          fontFamily: 'LexendRegular',
                          fontSize: 20,
                          color: blackColor,
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 10),
          Text(
            'Stored ${widget.label}', // Label for the list of stored images
            style: TextStyle(
              fontSize: 16,
              fontFamily: "LexendRegular",
              color: blackColor,
            ),
          ),
          Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: darkGrey50Color),
            child: ListView.builder(
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.file(
                        imageList[index],
                        fit: BoxFit.contain,
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
