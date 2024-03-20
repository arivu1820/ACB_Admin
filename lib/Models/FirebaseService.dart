import 'package:acb_admin/Screens/InstallUninstallScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
