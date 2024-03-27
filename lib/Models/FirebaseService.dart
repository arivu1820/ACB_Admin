import 'package:acb_admin/Screens/InstallUninstallScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateOrderOnProcess(String orderId, bool newValue) async {
    try {
      // Get reference to the document
      DocumentReference orderRef =
          _firestore.collection('CurrentOrders').doc(orderId);

      // Update the 'onProcess' field with the new value
      await orderRef.update({'onProcess': newValue});
    } catch (error) {
      print('Error updating order onProcess status: $error');
      throw error; // Throw error to handle it in the UI if needed
    }
  }
  Stream<QuerySnapshot> getCurrentAMCSubscription() {
    return _firestore.collection('CurrentAMCSubscription').snapshots();
  }

   Stream<QuerySnapshot> getAvailArea() {
    return _firestore.collection('AvailableArea').snapshots();
  }

  Stream<QuerySnapshot> getServicePartners() {
    return _firestore.collection('ServicePartner').snapshots();
  }

    Stream<QuerySnapshot> getCompletedAMCSubscription() {
    return _firestore.collection('CompletedAMCSubscription').snapshots();
  }

  Stream<QuerySnapshot> getCurrentOrders() {
    return _firestore.collection('CurrentOrders').snapshots();
  }

  Stream<QuerySnapshot> getCompletedOrders() {
    return _firestore.collection('CompletedOrders').snapshots();
  }

  Stream<DocumentSnapshot> getOrderdetails(
      String orderid, bool isordercompleted) {
    return isordercompleted
        ? _firestore.collection('CompletedOrders').doc(orderid).snapshots()
        : _firestore.collection('CurrentOrders').doc(orderid).snapshots();
  }

  Stream<QuerySnapshot> getGeneralProducts() {
    return _firestore.collection('GeneralProducts').snapshots();
  }

  Stream<QuerySnapshot> getProductsCategory() {
    return _firestore.collection('Categories').snapshots();
  }

  Stream<QuerySnapshot> getProducts(String CategoryId) {
    return _firestore
        .collection('Categories')
        .doc(CategoryId)
        .collection("Products")
        .snapshots();
  }

    Stream<DocumentSnapshot> getHomepageBanner() {
    return _firestore.collection('BannerImages').doc('HomePageBanner').snapshots();
  }

      Stream<DocumentSnapshot> getCartpageBanner() {
    return _firestore.collection('BannerImages').doc('CartPageBanner').snapshots();
  }

  Stream<DocumentSnapshot> getServicesBanner() {
    return _firestore
        .collection('Services')
        .doc('hWHRjpawA5D6OTbrjn3h')
        .snapshots();
  }


  Stream<DocumentSnapshot> GeneralService() {
    return _firestore
        .collection('Services')
        .doc('hWHRjpawA5D6OTbrjn3h')
        .collection('Categories')
        .doc('1GeneralService')
        .snapshots();
  }

  Stream<DocumentSnapshot> WetWash() {
    return _firestore
        .collection('Services')
        .doc('hWHRjpawA5D6OTbrjn3h')
        .collection('Categories')
        .doc('2WetWash')
        .snapshots();
  }

  Stream<DocumentSnapshot> Repair() {
    return _firestore
        .collection('Services')
        .doc('hWHRjpawA5D6OTbrjn3h')
        .collection('Categories')
        .doc('3Repair')
        .snapshots();
  }

  Stream<DocumentSnapshot> InstallUninstall() {
    return _firestore
        .collection('Services')
        .doc('hWHRjpawA5D6OTbrjn3h')
        .collection('Categories')
        .doc('4InstallUninstall')
        .snapshots();
  }

  Stream<DocumentSnapshot> AMC() {
    return _firestore
        .collection('Services')
        .doc('hWHRjpawA5D6OTbrjn3h')
        .collection('Categories')
        .doc('5AMC')
        .snapshots();
  }

  Stream<QuerySnapshot> getGeneralServices() {
    return _firestore
        .collection('Services')
        .doc('hWHRjpawA5D6OTbrjn3h')
        .collection('Categories')
        .doc('1GeneralService')
        .collection("GeneralService")
        .snapshots();
  }

  Stream<QuerySnapshot> getWetWash() {
    return _firestore
        .collection('Services')
        .doc('hWHRjpawA5D6OTbrjn3h')
        .collection('Categories')
        .doc('2WetWash')
        .collection("WetWash")
        .snapshots();
  }

  Stream<QuerySnapshot> getRepair() {
    return _firestore
        .collection('Services')
        .doc('hWHRjpawA5D6OTbrjn3h')
        .collection('Categories')
        .doc('3Repair')
        .collection("Repair")
        .snapshots();
  }

  Stream<QuerySnapshot> getInstallUninstall() {
    return _firestore
        .collection('Services')
        .doc('hWHRjpawA5D6OTbrjn3h')
        .collection('Categories')
        .doc('4InstallUninstall')
        .collection("InstallUninstall")
        .snapshots();
  }

  Stream<QuerySnapshot> getAMC() {
    return _firestore
        .collection('Services')
        .doc('hWHRjpawA5D6OTbrjn3h')
        .collection('Categories')
        .doc('5AMC')
        .collection("AMC")
        .snapshots();
  }
}
