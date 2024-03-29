import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextContainer extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isOptional;
  final int limit;
  final bool isnum;
  final bool isedit;
  final bool ispass;
  final String placeholder;
  final int minCharacters; // New property for minimum characters

  TextContainer({
    required this.controller,
    this.isedit = false,
    required this.limit,
    required this.isnum,
    required this.label,
    this.placeholder = '',
    this.ispass=false,
    this.isOptional = false,
    this.minCharacters = 1, // Set a default minimum character requirement
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
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
          TextFormField(
            enabled: isedit,
            
            
            keyboardType: isnum ? TextInputType.numberWithOptions(decimal: true) :  TextInputType.text,
            maxLength: limit,
            obscureText: ispass,

            controller: controller,
            inputFormatters: [
              if (isnum) FilteringTextInputFormatter.allow(RegExp(r'\d')), // Allow only numeric characters
            ],
            decoration: InputDecoration(
              filled: true,
              hintText: placeholder,
              fillColor: lightBlue20Color,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (!isOptional && (value == null || value.isEmpty)) {
                return "This field is required";
              }

              if (value != null && value.length < minCharacters) {
                return "Minimum $minCharacters characters required";
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
