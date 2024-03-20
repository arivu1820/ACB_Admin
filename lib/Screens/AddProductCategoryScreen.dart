import 'package:acb_admin/Screens/AddProductScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/ListItemsandAddItems.dart';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextListContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProductCategoryScreen extends StatefulWidget {
  final String category;
  final List<dynamic> tons;
  final List<dynamic> brands;
  final String categoryId;
  AddProductCategoryScreen(
      {super.key,
      this.category = '',
      this.brands = const [],
      this.tons = const [],
      this.categoryId = ""});

  @override
  State<AddProductCategoryScreen> createState() =>
      _AddProductCategoryScreenState();
}

class _AddProductCategoryScreenState extends State<AddProductCategoryScreen> {
  final TextEditingController CategoryNameController = TextEditingController();

  final TextEditingController TonsController = TextEditingController();

  final TextEditingController BrandsController = TextEditingController();
  List<dynamic> listedtons = [];
  List<dynamic> listedbrands = [];
  @override
  void initState() {
    super.initState();
    CategoryNameController.text = widget.category;
    listedbrands = widget.brands;
    listedtons = widget.tons;
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
          String name = CategoryNameController.text;
          // int mrp = int.parse(_mrpController.text);
          // int discount = int.parse(_discountController.text);

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );

          if (widget.categoryId.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection('Categories')
                .doc(widget.categoryId)
                .set({
              'Name': name,
              'Brands': listedbrands,
              'Tons': listedtons,
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Changes added successfully.'),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else if (widget.categoryId.isEmpty) {
            await FirebaseFirestore.instance.collection('Categories').add({
              'Name': name,
              'Brands': listedbrands,
              'Tons': listedtons,
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('New Category added successfully.'),
              ),
            );
            Navigator.of(context).pop();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(),
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
                    controller: CategoryNameController,
                    label: "Category Name",
                    limit: 50,
                    isnum: false,
                    isedit: isEditing,
                  ),
                  TextListContainer(
                    controller: TonsController,
                    label: "Tons",
                    limit: 20,
                    isnum: false,
                    fetchedlist: listedtons,
                    minCharacters: 1,
                    isedit: isEditing,
                    onTextListChanged: (List<String> list) {
                      setState(() {
                        listedtons = list;
                      });
                    },
                  ),
                  TextListContainer(
                    controller: BrandsController,
                    label: "Brands",
                    fetchedlist: listedbrands,
                    limit: 20,
                    isnum: false,
                    isedit: isEditing,
                    minCharacters: 0,
                    onTextListChanged: (List<String> list) {
                      setState(() {
                        listedbrands = list;
                      });
                    },
                  ),
                  widget.categoryId.isNotEmpty?
                  ListItemsandAddItems(
                    category: "Products",
                    name: widget.category.isNotEmpty
                        ? widget.category
                        : "Category",
                        categoryId: widget.categoryId,
                    screen: AddProductScreen(categoryId: widget.categoryId,),
                  ):const SizedBox(),
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
