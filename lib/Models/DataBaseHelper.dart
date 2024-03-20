// import 'package:acb_admin/Widgets/CombinedWidgets/InstallUninstall.dart';
// import 'package:acb_admin/Widgets/CombinedWidgets/InstallUninstallContentContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:acb_admin/Widgets/CombinedWidgets/HomePageProductsList.dart';

class DatabaseHelper {
  static Future<String?> getUid() async {
    User? user = await FirebaseAuth.instance.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      // User is not logged in
      return null;
    }
  }

  static removeGeneralProduct(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove General Product?'),
          content: const Text(
              'Are you sure you want to remove this product? This action will reflect for all users.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('GeneralProducts')
                    .doc(productId)
                    .delete()
                    .then((value) {
                  print('Product with ID $productId removed successfully');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product removed successfully'),
                    ),
                  );
                }).catchError((error) {
                  print('Failed to remove product: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to remove product'),
                    ),
                  );
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static removeProductCategory(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Category?'),
          content: const Text(
              'Are you sure you want to remove this Category? This action will reflect for all users.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Categories')
                    .doc(productId)
                    .delete()
                    .then((value) {
                  print('Category with ID $productId removed successfully');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Category removed successfully'),
                    ),
                  );
                }).catchError((error) {
                  print('Failed to remove category: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to remove category'),
                    ),
                  );
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static removeProduct(
      BuildContext context, String productId, String categoryId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Product?'),
          content: const Text(
              'Are you sure you want to remove this product? This action will reflect for all users.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Categories')
                    .doc(categoryId)
                    .collection('Products')
                    .doc(productId)
                    .delete()
                    .then((value) {
                  print('Product with ID $productId removed successfully');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product removed successfully'),
                    ),
                  );
                }).catchError((error) {
                  print('Failed to remove product: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to remove product'),
                    ),
                  );
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static removeService(BuildContext context, String productId,
      String categoryId, String categoryName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Service?'),
          content: const Text(
              'Are you sure you want to remove this product? This action will reflect for all users.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Services')
                    .doc('hWHRjpawA5D6OTbrjn3h')
                    .collection('Categories')
                    .doc(categoryId)
                    .collection(categoryName)
                    .doc(productId)
                    .delete()
                    .then((value) {
                  print('Service with ID $productId removed successfully');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Service removed successfully'),
                    ),
                  );
                }).catchError((error) {
                  print('Failed to remove service: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to remove service'),
                    ),
                  );
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}



// //#######################################################################################################//

//   static Future<void> addToProductCart({
//     required String uid,
//     required String productId,
//     required Map<String, dynamic> productDetails,
//   }) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('Users')
//           .doc(uid)
//           .collection('ProductsCart')
//           .doc(productId)
//           .set(productDetails);
//     } catch (error) {
//       print('Error adding to cart: $error');
//       throw error;
//     }
//   }

//   //#######################################################################################################//

//   static Future<void> addToGeneralProductCart({
//     required String uid,
//     required String productId,
//     required Map<String, dynamic> productDetails,
//   }) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('Users')
//           .doc(uid)
//           .collection('GeneralProductsCart')
//           .doc(productId)
//           .set(productDetails);
//     } catch (error) {
//       print('Error adding to cart: $error');
//       throw error;
//     }
//   }

//   //#######################################################################################################//

//   static Future<void> addToServiceCart({
//     required String uid,
//     required String serviceId,
//     required Map<String, dynamic> serviceDetails,
//   }) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('Users')
//           .doc(uid)
//           .collection('ServicesCart')
//           .doc(serviceId)
//           .set(serviceDetails);
//     } catch (error) {
//       print('Error adding to cart: $error');
//       throw error;
//     }
//   }

//     //#######################################################################################################//

//   static Future<void> addaddress({
//     required String uid,
//     required Map<String, dynamic> serviceDetails,
//   }) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('Users')
//           .doc(uid)
//           .collection('AddedAddress').doc()
//           .set(serviceDetails);
//     } catch (error) {
//       print('Error adding to cart: $error');
//       throw error;
//     }
//   }

//   //#######################################################################################################//

//   static Future<void> addToAMCCart({
//     required String uid,
//     required String productId,
//     required Map<String, dynamic> productDetails,
//   }) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('Users')
//           .doc(uid)
//           .collection('AMCCart')
//           .doc(productId)
//           .set(productDetails);
//     } catch (error) {
//       print('Error adding to cart: $error');
//       throw error;
//     }
//   }


//   //#######################################################################################################//

//   static Stream<QuerySnapshot> getCategoryStream() {
//     return FirebaseFirestore.instance.collection('Categories').snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<QuerySnapshot> getProductStream(DocumentReference categoryRef) {
//     return categoryRef.collection('Products').snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<QuerySnapshot> getServicesCollection() {
//     return FirebaseFirestore.instance.collection('Services').snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<QuerySnapshot> getServicesCategoriesCollection(String ID) {
//     return FirebaseFirestore.instance
//         .collection('Services')
//         .doc("hWHRjpawA5D6OTbrjn3h")
//         .collection("Categories")
//         .snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<DocumentSnapshot> getAMCImg() {
//     return FirebaseFirestore.instance
//         .collection('Services')
//         .doc("hWHRjpawA5D6OTbrjn3h")
//         .collection("Categories")
//         .doc("5AMC")
//         .snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<QuerySnapshot> getSplitACCollection() {
//     return FirebaseFirestore.instance
//         .collection('Services')
//         .doc("hWHRjpawA5D6OTbrjn3h")
//         .collection("Categories")
//         .doc("5AMC")
//         .collection("AMC") // To change AMC to SplitAC
//         .snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<QuerySnapshot> getWindowACCollection() {
//     return FirebaseFirestore.instance
//         .collection('Services')
//         .doc("hWHRjpawA5D6OTbrjn3h")
//         .collection("Categories")
//         .doc("5AMC")
//         .collection("WindowAC")
//         .snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<QuerySnapshot> getCassetteACCollection() {
//     return FirebaseFirestore.instance
//         .collection('Services')
//         .doc("hWHRjpawA5D6OTbrjn3h")
//         .collection("Categories")
//         .doc("5AMC")
//         .collection("CassetteAC")
//         .snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<QuerySnapshot> GeneralServiceCollection(String ID) {
//     return FirebaseFirestore.instance
//         .collection('Services')
//         .doc(ID)
//         .collection("Categories")
//         .doc('1GeneralService')
//         .collection("GeneralService")
//         .snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<QuerySnapshot> RepairCollection(String ID) {
//     return FirebaseFirestore.instance
//         .collection('Services')
//         .doc(ID)
//         .collection("Categories")
//         .doc('3Repair')
//         .collection("Repair")
//         .snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<QuerySnapshot> InstallUninstallCollection(String ID) {
//     return FirebaseFirestore.instance
//         .collection('Services')
//         .doc(ID)
//         .collection("Categories")
//         .doc('4InstallUninstall')
//         .collection("InstallUninstall")
//         .snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<QuerySnapshot> WetWashCollection(String ID) {
//     return FirebaseFirestore.instance
//         .collection('Services')
//         .doc(ID)
//         .collection("Categories")
//         .doc('2WetWash')
//         .collection("WetWash")
//         .snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<QuerySnapshot> getProductsForCategory(String categoryId) {
//     return FirebaseFirestore.instance
//         .collection('Categories')
//         .doc(categoryId)
//         .collection('Products')
//         .snapshots();
//   }

//   //#######################################################################################################//

//   static Stream<Map<String, List<dynamic>>> getTonsAndBrandsForCategory(
//       String categoryId) {
//     return FirebaseFirestore.instance
//         .collection('Categories')
//         .doc(categoryId)
//         .snapshots()
//         .map((snapshot) {
//       final Map<String, dynamic>? data = snapshot.data();
//       if (data != null) {
//         final List<dynamic> tons = data['Tons'] ?? [];
//         final List<dynamic> brands = data['Brands'] ?? [];

//         return {'tons': tons, 'brands': brands};
//       } else {
//         return {'tons': [], 'brands': []};
//       }
//     }).cast<Map<String, List<dynamic>>>();
//   }

// //#######################################################################################################//

//   static Stream<DocumentSnapshot> getProductById(
//       String categoryId, String productId) {
//     return FirebaseFirestore.instance
//         .collection('Categories')
//         .doc(categoryId)
//         .collection('Products')
//         .doc(productId)
//         .snapshots();
//   }

//   //#######################################################################################################//

//   static List<Widget> buildProductsList(String uid,
//       List<QueryDocumentSnapshot> categoryDocs) {
//     List<Widget> productsList = [];

//     for (QueryDocumentSnapshot categoryDoc in categoryDocs) {
//       String categoryName = categoryDoc['Name'];
//       String categoryId = categoryDoc.id;

//       productsList.add(
//         StreamBuilder<QuerySnapshot>(
//           stream: getProductStream(categoryDoc.reference),
//           builder: (context, productSnapshot) {
//             return buildProductListWidget(
//                 categoryId, categoryName,uid, productSnapshot,);
//           },
//         ),
//       );
//     }

//     return productsList;
//   }

//   //#######################################################################################################//

//   static Widget buildProductListWidget(String categoryId, String categoryName,String uid,
//       AsyncSnapshot<QuerySnapshot> productSnapshot) {
//     if (productSnapshot.connectionState == ConnectionState.waiting) {
//       return CircularProgressIndicator();
//     }

//     if (productSnapshot.hasError) {
//       return Text('Error: ${productSnapshot.error}');
//     }

//     List<String> productName = [];
//     List<String> imageUrl = [];

//     for (QueryDocumentSnapshot productDoc in productSnapshot.data!.docs) {
//       String proName = productDoc['Name'];
//       productName.add(proName);
//     }

//     for (QueryDocumentSnapshot productImg in productSnapshot.data!.docs) {
//       List<dynamic>? images = productImg['Images'];

//       if (images != null && images.isNotEmpty) {
//         String firstImageUrl = images[0];
//         imageUrl.add(firstImageUrl);
//       }
//     }

//     return HomePageProductsList(
//       CategoryId: categoryId,
//       CategoryName: categoryName,
//       ProductName: productName,
//       ImageURL: imageUrl,
//       uid: uid,
//     );
//   }

//   //#######################################################################################################//
// }
