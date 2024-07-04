import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:by_cycle/models/User.dart';

class UserRepository {
  //Takes a User object as a mandatory argument and
  //an optional name for the document in firestore
  Future<void> addUserToFirestore(User data, {String? documentId}) async {
    try {
      if (documentId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .set(data.toMap());
      } else {
        await FirebaseFirestore.instance.collection('users').add(data.toMap());
      }
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
      print('Error getting all users from Firestore: $e');
    }
  }

  Future<User?> getUserFromFirestoreById(String documentId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(documentId)
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final user = User.fromMap(data);
        //print(user!.email);
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

  void sendDailyData(DailyDataInput dailyDataInput) {
    //Add the daily data input to the user's daily_data_input list
    FirebaseFirestore.instance.collection("users").add(dailyDataInput.toMap());
    print("Daily data sent");
  }
}
