import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:by_cycle/models/user.dart';
import 'package:by_cycle/models/daily_data_input.dart';
import 'package:logger/logger.dart';

class UserRepository {
  var logger = Logger();
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
      logger.d('Error adding data to Firestore: $e');
    }
  }

  Future<void> getAllUsersFromFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('users').get().then((event) {
        for (var doc in event.docs) {
          logger.d("${doc.id} => ${doc.data()}");
        }
      });
    } catch (e) {
      logger.d('Error getting all users from Firestore: $e');
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
        //logger.d(user!.email);
        return user;
      },
      onError: (e) => logger.d("Error getting document: $e"),
    );
    return null;
  }

  Future<User?> getUserByEmailFromFirestore(String email) async {
    try {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .get();

      for (var doc in qs.docs) {
        final user = User.fromMap(doc.data() as Map<String, dynamic>);
        return user;
      }
    } catch (e) {
      logger.d("Error getting user by email: $e");

      return null;
    }
    return null;
  }

  Future<void> sendDailyData(DailyDataInput dailyDataInput) async {
    //Add the daily data input to the user's daily_data_input list
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .add(dailyDataInput.toMap());
      logger.d("Daily data sent");
    } catch (e) {
      logger.d("Error: $e");
    }
  }

  Future<void> saveOnboardingData(OnBoardingQuestions formData) async {
    try {
      await FirebaseFirestore.instance
          .collection('onboarding')
          .add(formData.toMap());
    } catch (e) {
      logger.d('Error adding data to Firestore: $e');
    }
  }

//TODO - Might be completely irrelevant at this point but I'm leaving it here for now as an example
  Future<String> getTodaysPhase() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          //TODO - Change this to the user's id
          // new_pb_longer_cycle
          // in menstruation

          // new_pcos_pa
          // in luteal

          // new_pa_lucia
          // in follicular

          // new_ovulating user
          // in ovulation
          .doc("new_pb_longer_cycle")
          .get();

      var data = snapshot.data() as Map<String, dynamic>;
      var dailyDataInput = data['daily_data_input'];
      int index = findDailyDataInputIndexByDate(dailyDataInput, DateTime.now());
      var phase = dailyDataInput[index]['phase'];
      logger.d(phase);
      return phase;
    } catch (e) {
      logger.d("Error getting user data");
      return "Error - No data found";
    }
  }

  // a handy function for identifying the index of a dailyDataInput on a specific day.
  int findDailyDataInputIndexByDate(
      List<dynamic> dailyDataInputs, DateTime targetDate) {
    for (int i = 0; i < dailyDataInputs.length; i++) {
      dynamic input = dailyDataInputs[i];
      DateTime inputDate = input['date'].toDate();
      if (inputDate.year == targetDate.year &&
          inputDate.month == targetDate.month &&
          inputDate.day == targetDate.day) {
        return i;
      }
    }
    return -1; // Return -1 if no matching date is found
  }
}
