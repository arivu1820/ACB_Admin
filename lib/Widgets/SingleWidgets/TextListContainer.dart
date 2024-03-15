import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextListContainer extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isOptional;
  final int limit;
  final bool isnum;
  final int minCharacters; // New property for minimum characters

  TextListContainer({
    required this.controller,
    required this.limit,
    required this.isnum,
    required this.label,
    this.isOptional = false,
    this.minCharacters = 1, // Set a default minimum character requirement
  });

  @override
  _TextListContainerState createState() => _TextListContainerState();
}

class _TextListContainerState extends State<TextListContainer> {
  List<String> textList = []; // List to store entered text values

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: "LexendRegular",
              color: blackColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: widget.isnum ? TextInputType.number : TextInputType.text,
                  maxLength: widget.limit,
                  controller: widget.controller,
                  inputFormatters: [
                    if (widget.isnum) FilteringTextInputFormatter.allow(RegExp(r'\d')), // Allow only numeric characters
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: lightBlue20Color,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (!widget.isOptional && (value == null || value.isEmpty)) {
                      return "This field is required";
                    }
                
                    if (value != null && value.length < widget.minCharacters) {
                      return "Minimum ${widget.minCharacters} characters required";
                    }
                
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10), // Added SizedBox for spacing
              InkWell(
                onTap: () {
                  setState(() {
                    if (widget.controller.text.isNotEmpty) {
                      textList.add(widget.controller.text);
                      widget.controller.clear();
                    }
                  });
                },
                child: Container(
                  width: 150,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), 
                    color: lightBlueColor,
                  ),
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontFamily: 'LexendRegular', 
                        fontSize: 20, 
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Added spacing
          Text(
            'Stored ${widget.label}', // Label for the list of stored texts
            style: TextStyle(
              fontSize: 16,
              fontFamily: "LexendRegular",
              color: blackColor,
            ),
          ),
          Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: darkGrey20Color),
            child: ListView.builder(
              itemCount: textList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                  child: Row(
                    children: [
                      Text(
                        textList[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "LexendRegular",
                          color: blackColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            textList.removeAt(index);
                          });
                        },
                        child: Image.asset(
                          'Assets/Close_Cross_Icon.png',
                          width: 20,
                          height: 20,
                          // Adjust the path and size as per your actual image
                        ),
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
