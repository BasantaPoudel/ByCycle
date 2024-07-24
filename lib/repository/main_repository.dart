import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class MainRepository {
  var logger = Logger();
  Future<void> addDataToFirestore(Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('users').add(data);
    } catch (e) {
      logger.d('Error adding data to Firestore: $e');
    }
  }
}
