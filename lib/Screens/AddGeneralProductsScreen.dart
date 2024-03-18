import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/SingleImageUploadContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddGeneralProductsScreen extends StatefulWidget {
  AddGeneralProductsScreen({super.key});

  @override
  State<AddGeneralProductsScreen> createState() =>
      _AddGeneralProductsScreenState();
}

class _AddGeneralProductsScreenState extends State<AddGeneralProductsScreen> {
  final TextEditingController NameController = TextEditingController();

  final TextEditingController MRPController = TextEditingController();

  final TextEditingController DiscountController = TextEditingController();

  final TextEditingController StockController = TextEditingController();

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
    // Handle form submission here
    if (_formKey.currentState!.validate()) {
      try {
        // Access form field values
        String name = NameController.text;
        int mrp = int.parse(MRPController.text);
        int discount = int.parse(DiscountController.text);
        int stock = int.parse(StockController.text);

        // Upload data to Firebase Firestore
        await FirebaseFirestore.instance.collection('GeneralProducts').add({
          'Name': name,
          'MRP': mrp,
          'Discount': discount,
          'Stock': stock,
          'Image': 'https://image.png',
          // 'timestamp': FieldValue.serverTimestamp(), // Optional: Add timestamp
        }).then((value) {
          // Handle successful upload
          ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                          content: Text('GeneralProduct added successfully.'),
                        ),
                      );
        }).catchError((error) {
          // Handle error during upload
          ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error uploading data: $error'),
                        ),
                      );
        });

        // Navigator.of(context).pop();

        // ScaffoldMessenger.of(context).showSnackBar(
        //                const SnackBar(
        //                   content: Text('GeneralProduct added successfully.'),
        //                 ),
        //               );

      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                          content: Text('Failed to add, Try after sometime!'),
                        ),
                      );
        // Handle parsing error
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
                    controller: NameController,
                    label: "Name",
                    limit: 500,
                    isnum: false,
                    minCharacters: 1,
                    isedit: isEditing,
                  ),
                  TextContainer(
                    controller: MRPController,
                    label: "MRP",
                    limit: 10,
                    isnum: true,
                    minCharacters: 1,
                    isedit: isEditing,
                  ),
                  TextContainer(
                    controller: DiscountController,
                    label: "Discount",
                    limit: 3,
                    isnum: true,
                    minCharacters: 1,
                    isedit: isEditing,
                  ),
                  TextContainer(
                    controller: StockController,
                    label: "Stock",
                    limit: 3,
                    isnum: true,
                    isedit: isEditing,
                    minCharacters: 1,
                  ),
                  SingleImageUploadContainer(
                    name: 'Image',
                  ),
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




// import 'package:acbaradise_2024/Models/DataBaseHelper.dart';
// import 'package:acbaradise_2024/Theme/Colors.dart';
// import 'package:acbaradise_2024/Widgets/SingleWidgets/AppbarWithCart.dart';
// import 'package:acbaradise_2024/Widgets/SingleWidgets/CommonBtn.dart';
// import 'package:acbaradise_2024/Widgets/SingleWidgets/TextContainer.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class AddAddressDetailsScreen extends StatelessWidget {
//   final String uid;

//   final TextEditingController field1Controller = TextEditingController();
//   final TextEditingController field2Controller = TextEditingController();
//   final TextEditingController field3Controller = TextEditingController();
//   final TextEditingController field4Controller = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   AddAddressDetailsScreen({required this.uid});



//   static const LatLng sourcelocaion = LatLng(37.00, 52.3);

//   @override
//   Widget build(BuildContext context) {

  //     void _submitForm(
  //   TextEditingController field1Controller,
  //   TextEditingController field2Controller,
  //   TextEditingController field3Controller,
  //   TextEditingController field4Controller,
  // ) async {
  //   if (_formKey.currentState!.validate()) {
  //     // Your logic here
  //     Map<String, dynamic> ServiceDetails = {
  //       'HouseNoFloor': field1Controller.text,
  //       'BuildingStreet' : field2Controller.text,
  //       'LandmarkAreaName' : field3Controller.text,
  //       'Contact' : field4Controller.text,
  //       'isSelected' : true,
  //     };

  //     try {
        
  //       await FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(uid)
  //         .collection('AddedAddress')
  //         .get()
  //         .then((querySnapshot) {
  //       for (QueryDocumentSnapshot doc in querySnapshot.docs) {
  //         doc.reference.update({'isSelected': false});
  //       }
  //     });
      
  //       await DatabaseHelper.addaddress(
  //         uid: uid,
  //         serviceDetails: ServiceDetails,
  //       );

  //       Navigator.of(context).pop();

  //       ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(
  //                         content: Text('Address add successfully'),
  //                       ),
  //                     );

  //       // You can access the text from the controllers like this:

  //       // Do something with the values if needed.
  //     } catch (error) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(
  //                         content: Text('Address not added'),
  //                       ),
  //                     );
  //       // Handle error
  //     }
  //   } 
  // }

//     return Scaffold(
//       backgroundColor: whiteColor,
//       appBar: AppbarWithCart(
//         PageName: "Add Address Detail",
//         iscart: false,
//         uid: uid,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: 400,
//               width: double.infinity,
//               color: lightBlue25Color,
//               child: GoogleMap(
//                   initialCameraPosition:
//                       CameraPosition(target: sourcelocaion, zoom: 14.5),
//                   markers: {
//                     Marker(
//                         markerId: MarkerId("source"), position: sourcelocaion),
//                   }),
//             ),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextContainer(
//                     controller: field1Controller,
//                     label: "House No. & Floor",
//                     limit: 15,
//                     isnum: false,
//                   ),
//                   TextContainer(
//                     controller: field2Controller,
//                     label: "Building & Street",
//                     limit: 50,
//                     isnum: false,
//                     minCharacters: 5,
//                   ),
//                   TextContainer(
//                     controller: field3Controller,
//                     label: "Landmark & Area Name (Optional)",
//                     isOptional: true,
//                     limit: 50,
//                     isnum: false,
//                     minCharacters: 0,
//                   ),
//                   TextContainer(
//                     controller: field4Controller,
//                     label: "Contact No.",
//                     limit: 10,
//                     isnum: true,
//                     minCharacters: 10,
//                   ),
//                   CommonBtn(
//   BtnName: "Save Address",
//   function: () => _submitForm(field1Controller, field2Controller, field3Controller, field4Controller),
//   isSelected: true,
// ),


//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
