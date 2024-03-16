import 'package:acb_admin/Screens/AddAMCSchemeScreen.dart';
import 'package:acb_admin/Screens/CommonServicesScreen.dart';
import 'package:acb_admin/Theme/Colors.dart';
import 'package:acb_admin/Widgets/CombinedWidgets/ListItemsandAddItems.dart';
import 'package:acb_admin/Widgets/SingleWidgets/EditandSubmitBtn.dart';
import 'package:acb_admin/Widgets/SingleWidgets/SingleImageUploadContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextContainer.dart';
import 'package:acb_admin/Widgets/SingleWidgets/TextListContainer.dart';
import 'package:flutter/material.dart';

class AMCScreen extends StatelessWidget {
  AMCScreen({super.key});

  final TextEditingController ServiceNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            EditandSumbitBtn(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextContainer(
                    controller: ServiceNameController,
                    label: "Service Name",
                    limit: 50,
                    isnum: false,
                  ),
                  SingleImageUploadContainer(
                    name: 'Banner Image',
                  ),
                  SingleImageUploadContainer(
                    name: 'Split AC Image',
                  ),
                  SingleImageUploadContainer(
                    name: 'Window AC Image',
                  ),
                  SingleImageUploadContainer(
                    name: 'Cassette AC Image',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                   ListItemsandAddItems(
                    category: "SCHEME",
                    name: 'AMC',
                    screen: AddAMCSchemeScreen(),
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

//       void _submitForm(
//     TextEditingController field1Controller,
//     TextEditingController field2Controller,
//     TextEditingController field3Controller,
//     TextEditingController field4Controller,
//   ) async {
//     if (_formKey.currentState!.validate()) {
//       // Your logic here
//       Map<String, dynamic> ServiceDetails = {
//         'HouseNoFloor': field1Controller.text,
//         'BuildingStreet' : field2Controller.text,
//         'LandmarkAreaName' : field3Controller.text,
//         'Contact' : field4Controller.text,
//         'isSelected' : true,
//       };

//       try {
        
//         await FirebaseFirestore.instance
//           .collection('Users')
//           .doc(uid)
//           .collection('AddedAddress')
//           .get()
//           .then((querySnapshot) {
//         for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//           doc.reference.update({'isSelected': false});
//         }
//       });
      
//         await DatabaseHelper.addaddress(
//           uid: uid,
//           serviceDetails: ServiceDetails,
//         );

//         Navigator.of(context).pop();

//         ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Address add successfully'),
//                         ),
//                       );

//         // You can access the text from the controllers like this:

//         // Do something with the values if needed.
//       } catch (error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Address not added'),
//                         ),
//                       );
//         // Handle error
//       }
//     } 
//   }

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
