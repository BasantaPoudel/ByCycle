import 'package:cloud_firestore/cloud_firestore.dart';

class MainRepository {
  Future<void> addDataToFirestore(Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('users').add(data);
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }
}
