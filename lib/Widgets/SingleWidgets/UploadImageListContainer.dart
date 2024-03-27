import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageListContainer extends StatefulWidget {
  final String name;
  final bool isedit;
  final List<Uint8List> selectedImages;
  final Function(List<Uint8List>) onImagesSelected;
  final Function(List<dynamic>) onfetchedImagesremoved;
  final List<dynamic> imgs;

  const UploadImageListContainer({
    Key? key,
    required this.name,
    this.isedit = false,
    required this.selectedImages,
    required this.onfetchedImagesremoved,
    required this.onImagesSelected,
    this.imgs = const [],

    // required Null Function(Uint8List? image) onImageSelected,
  }) : super(key: key);

  @override
  _UploadImageListContainerState createState() =>
      _UploadImageListContainerState();
}

class _UploadImageListContainerState extends State<UploadImageListContainer> {
  List<dynamic> fetchedimageslist = [];
  List<dynamic> removedimages = []; // List to hold selected images

  @override
  void initState() {
    super.initState();
    fetchedimageslist = widget.imgs;
    // widget.onfetchedImagesremoved(fetchedimageslist);
  }

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery, // For selecting from gallery
      // You can also add ImageSource.camera to allow capturing from the camera
    );
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        widget.selectedImages.add(bytes);
      });
      widget.onImagesSelected(
          widget.selectedImages); // Pass the selected images list
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Row(
                  children: [
                    for (var i = 0; i < fetchedimageslist.length; i++)
                      Row(
                        children: [
                          Stack(children: [
                            (Image.network(
                              widget.imgs[i],
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            )),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap:!widget.isedit?(){}: () {
                                  setState(() {
                                    var removedValue =
                                        fetchedimageslist.removeAt(i);
                                    removedimages.add(removedValue);
                                  });
                                  widget.onfetchedImagesremoved(
                                      removedimages);
                                },
                                child: CircleAvatar(
                                  radius: 10,
                                  child: Image.asset('Assets/Close_Cross_Icon.png',width: 20,height:20,),
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (var i = 0; i < widget.selectedImages.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Stack(
                          children: [
                            Image.memory(
                              widget.selectedImages[i],
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap:!widget.isedit? (){}: () {
                                  setState(() {
                                    widget.selectedImages.removeAt(i);
                                  });
                                  widget
                                      .onImagesSelected(widget.selectedImages);
                                },
                                child:  CircleAvatar(
                                  radius: 10,
                                  child:  Image.asset('Assets/Close_Cross_Icon.png',width: 20,height:20,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: !widget.isedit? (){}: () => _pickImage(context),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue),
                          ),
                          child:                             Image.asset('Assets/upload.png',width: 50,height: 50,),

                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
