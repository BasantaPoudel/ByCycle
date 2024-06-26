import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:by_cycle/models/User.dart';

class UserRepository {
  Future<void> addUserToFirestore(User data) async {
    try {
      await FirebaseFirestore.instance.collection('users').add(data.toMap());
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }

  Future<void> getAllUsersFromFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('users').get().then((event) {
        for (var doc in event.docs) {
          print("${doc.id} => ${doc.data()}");
        }
      });
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }

  Future<User?> getUserFromFirestoreById(String documentId) async {
    //Returns null until data is successfully fetched
    await FirebaseFirestore.instance
        .collection("users")
        .doc(documentId)
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final user = User.fromMap(data);
        return user;
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return null;
  }

  Future<void> getUserByEmailFromFirestore(String email) async {
    FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
