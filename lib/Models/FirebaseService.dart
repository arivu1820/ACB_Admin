import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getGeneralProducts() {
    return _firestore.collection('GeneralProducts').snapshots();
  }
}
