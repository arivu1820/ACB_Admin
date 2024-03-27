import 'dart:io';
import 'dart:typed_data';
import 'package:acb_admin/Widgets/SingleWidgets/Appbar.dart';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/SingleImageUploadContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class AddServicePartnerScreen extends StatefulWidget {
  final String name, email, number, password;

  final String productId;
  AddServicePartnerScreen(
      {Key? key,
      this.productId = '',
      this.email = '',
      this.name = '',
      this.number = '',
      this.password = ''})
      : super(key: key);

  @override
  State<AddServicePartnerScreen> createState() =>
      _AddGeneralProductsScreenState();
}

class _AddGeneralProductsScreenState extends State<AddServicePartnerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    _numberController.text = widget.number;
    _passwordController.text = widget.password;
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
          String name = _nameController.text;
          String email = _emailController.text;
          String number = _numberController.text;
          String password = _passwordController.text;
          String uid = '';

          if (widget.productId.isEmpty) {
            UserCredential userCredential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );

            // Get the UID of the newly created user
             uid = userCredential.user!.uid;
          }

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );

          if (widget.productId.isNotEmpty) {
            await FirebaseFirestore.instance
                .collection('ServicePartner')
                .doc(widget.productId)
                .set({
              'email': email,
              'name': name,
              'number': number,
              'password': password,
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Changes added successfully.'),
              ),
            );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          } else {
            await FirebaseFirestore.instance.collection('ServicePartner').doc(uid).set({
              'email': email,
              'name': name,
              'number': number,
              'password': password,
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('New Service Partner added successfully.'),
              ),
            );
            Navigator.of(context).pop();
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
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
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
                    controller: _nameController,
                    label: "Name",
                    limit: 30,
                    isnum: false,
                    minCharacters: 3,
                    isedit: isEditing,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextContainer(
                    controller: _numberController,
                    label: "Number",
                    limit: 10,
                    isnum: true,
                    minCharacters: 10,
                    isedit: isEditing,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextContainer(
                    controller: _emailController,
                    label: "E-mail",
                    placeholder: 'e-mail@acb.acbaradise.in',
                    limit: 30,
                    isnum: false,
                    minCharacters: 3,
                    isedit: widget.productId == '' ? isEditing : false,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextContainer(
                    controller: _passwordController,
                    label: "Password",
                    limit: 30,
                    isnum: false,
                    minCharacters: 8,
                    isedit: widget.productId == '' ? isEditing : false,
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
