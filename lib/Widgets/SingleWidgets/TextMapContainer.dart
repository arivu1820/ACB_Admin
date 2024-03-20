import 'package:acb_admin/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextMapContainer extends StatefulWidget {
  final TextEditingController firstcontroller;
  final TextEditingController secondcontroller;
  final String label;
  final bool isOptional;
  final int limit;
  final bool isnum;
  final bool isedit;
  final Map<String, dynamic> fetchedmap;
  final int minCharacters;
  final Function(Map<String, dynamic>)? onTextmapChanged;

  TextMapContainer({
    required this.firstcontroller,
    required this.secondcontroller,
    required this.limit,
    required this.isnum,
    this.isedit = false,
    required this.label,
    this.fetchedmap = const {},
    this.onTextmapChanged,
    this.isOptional = false,
    this.minCharacters = 1,
  });

  @override
  _TextMapContainerState createState() => _TextMapContainerState();
}

class _TextMapContainerState extends State<TextMapContainer> {
  Map<String, dynamic> textList = {};

  @override
  void initState() {
    super.initState();
    textList = Map<String, dynamic>.from(widget.fetchedmap);
  }

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
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  enabled: widget.isedit,
                  keyboardType:
                      widget.isnum ? TextInputType.number : TextInputType.text,
                  maxLength: widget.limit,
                  controller: widget.firstcontroller,
                  inputFormatters: [
                    if (widget.isnum)
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: lightBlue20Color,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  enabled: widget.isedit,
                  keyboardType:
                      widget.isnum ? TextInputType.number : TextInputType.text,
                  maxLength: widget.limit,
                  controller: widget.secondcontroller,
                  inputFormatters: [
                    if (widget.isnum)
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: lightBlue20Color,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  if (widget.firstcontroller.text.isNotEmpty &&
                      widget.secondcontroller.text.isNotEmpty) {
                    setState(() {
                      textList[widget.firstcontroller.text] =
                          widget.secondcontroller.text;
                      widget.firstcontroller.clear();
                      widget.secondcontroller.clear();
                      if (widget.onTextmapChanged != null) {
                        widget.onTextmapChanged!(textList);
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please fill both input fields',
                          style: TextStyle(
                            fontFamily: 'LexendRegular',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 150,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: lightBlueColor,
                  ),
                  child: const Center(
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
          const SizedBox(height: 20),
          Text(
            'Stored ${widget.label}',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: "LexendRegular",
              color: blackColor,
            ),
          ),
          Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: darkGrey20Color,
            ),
            child: ListView.builder(
              itemCount: textList.length,
              itemBuilder: (context, index) {
                final key = textList.keys.elementAt(index);
                final value = textList[key];
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    children: [
                      Text(
                        key,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "LexendRegular",
                          color: blackColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        value.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "LexendRegular",
                          color: blackColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: !widget.isedit
                            ? () {}
                            : () {
                                setState(() {
                                  textList.remove(key);
                                  if (widget.onTextmapChanged != null) {
                                    widget.onTextmapChanged!(textList);
                                  }
                                });
                              },
                        child: Image.asset(
                          'Assets/Close_Cross_Icon.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.firstcontroller.dispose();
    widget.secondcontroller.dispose();
    super.dispose();
  }
}
