import 'package:by_cycle/algorithms/choose_insight_ids_based_on_list_of_tags.dart';
import 'package:by_cycle/algorithms/onboard_calendar.dart';
import 'package:by_cycle/algorithms/produce_tags.dart';
import 'package:by_cycle/algorithms/redraw_calendar.dart';
import 'package:by_cycle/algorithms/retrieve_insights_by_their_ids.dart';
import 'package:by_cycle/algorithms/update_users_algorithm_data.dart';
import 'package:by_cycle/models/custom_date_time_range.dart';
import 'package:by_cycle/models/onboarding_questions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:by_cycle/models/user_model.dart';
import 'package:by_cycle/models/daily_data_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class UserRepository {
  var logger = Logger();
  User? loggedInUser = FirebaseAuth.instance.currentUser;

  Future<void> updateUserInFirebase(UserModel user,
      {String? documentId}) async {
    String email = loggedInUser!.email!;
    logger.d(user.toMap());
    try {
      // Reference to the Firestore collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Query to find the document by email
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: email).get();

      // Check if the query returns any documents
      if (querySnapshot.docs.isNotEmpty) {
        // Assume there is one document with the given email
        DocumentSnapshot userDoc = querySnapshot.docs.first;

        // Update the document
        await userDoc.reference.set(user.toMap());

        logger.d("User updated successfully!");
      } else {
        logger.d("No user found with the given email.");
      }
    } catch (e) {
      logger.d('Error adding data to Firestore: $e');
    }
  }

  //Takes a User object as a mandatory argument and
  //an optional name for the document in firestore
  Future<void> addUserToFirestore(UserModel data, {String? documentId}) async {
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

  Future<UserModel?> getUserFromFirestoreById(String documentId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(documentId)
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final user = UserModel.fromMap(data);
        //logger.d(user!.email);
        return user;
      },
      onError: (e) => logger.d("Error getting document: $e"),
    );
    return null;
  }

  Future<UserModel?> getUserByEmailFromFirestore(String email) async {
    try {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .get();

      for (var doc in qs.docs) {
        var data = doc.data() as Map<String, dynamic>;
        final user = UserModel.fromMap(data);

        return user;
      }
    } catch (e) {
      logger.d("Error getting user by email: $e");
    }
    return null;
  }

  Future<UserModel?> getCurrentUserFromFirestore() async {
    try {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: loggedInUser!.email!)
          .get();

      for (var doc in qs.docs) {
        var data = doc.data() as Map<String, dynamic>;
        final user = UserModel.fromMap(data);

        return user;
      }
    } catch (e) {
      logger.d("Error getting user by email: $e");
    }
    return null;
  }

//This query is important for now as it is used to get the new user's data which has only two fields
  Future<UserModel?> getNewUser(String email) async {
    try {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .get();

      for (var doc in qs.docs) {
        var data = doc.data() as Map<String, dynamic>;
        final user = UserModel(
          email: data['email'],
          name: data['name'],
          lastPeriod: DateTime.now(),
          dailyDataInput: [],
          phaseRanges: [],
          algorithmData: {
            "averageSleepTime": {
              "menstruation": {
                "inMinutes": 0,
                "count": 0,
              },
              "follicular": {
                "inMinutes": 0,
                "count": 0,
              },
              "ovulation": {
                "inMinutes": 0,
                "count": 0,
              },
              "luteal": {
                "inMinutes": 0,
                "count": 0,
              },
            }
          },
          tags: {},
        );
        return user;
      }
    } catch (e) {
      logger.d("Error getting user by email: $e");
      return null;
    }
    return null;
  }

  Future<void> saveOnboardingData(OnBoardingQuestions formData) async {
    String email = loggedInUser!.email!;
    UserModel user = await getNewUser(email) as UserModel;
    updateUserOnboardingDataInUserModel(user, formData);
    onboardCalendar(user);
    runAlgorithmAfterUserSubmitsData(user);
    await updateUserInFirebase(user);
  }

//TODO - Might be completely irrelevant at this point but I'm leaving it here for now as an example
  Future<String> getTodaysPhase() async {
    UserModel user =
        await getUserByEmailFromFirestore(loggedInUser!.email!) as UserModel;
    try {
      var dailyDataInput = user.dailyDataInput;
      int index = findDailyDataInputIndexByDate(dailyDataInput, DateTime.now());
      var phase = dailyDataInput[index].phase;
      logger.d(phase);
      return phase;
    } catch (e) {
      logger.d("Error getting user data");
      return "Error - No data found";
    }
  }

  Future<void> saveDailyDataInputData(DailyDataInput formData) async {
    UserModel user =
        await getUserByEmailFromFirestore(loggedInUser!.email!) as UserModel;
    logger.d(
        "User's today' dailyDataInput after updating with info from DDI widget");
    updateDailyDataInUserModel(user, formData);
    runAlgorithmAfterUserSubmitsData(user);
    await updateUserInFirebase(user);
  }

  Future<List<CustomDateTimeRange>> getPhaseRanges() async {
    //TODO - This is a temporary solution as fetching the new user's data can only occur after pushing the data to firebase but as they are not pushed to firebase yet, we need to wait for a few seconds before fetching the data
    await Future.delayed(Duration(seconds: 5));
    UserModel user =
        await getUserByEmailFromFirestore(loggedInUser!.email!) as UserModel;
    return user.phaseRanges;
  }

  updateUserOnboardingDataInUserModel(
      UserModel user, OnBoardingQuestions formData) {
    user.completeCycleLength = formData.completeCycleLength;
    user.cycleHeavy = formData.cycleHeavy;
    user.cycleRegular = formData.cycleRegular;
    user.lastPeriod = formData.lastPeriod;
    user.menstruationPhaseLength = formData.menstruationPhaseLength;
    // user.reminder = formData.remindersAboutDataLogIn;
    // user.would_like_reminders_about_self_care_checklist = formData.remindersAboutSelfCareChecklist;
    user.timeToFallAsleep = formData.timeToFallAsleep;
    user.would_like_reminders_about_data_log_in = formData.wouldLikeReminders;
  }

  updateDailyDataInUserModel(UserModel user, DailyDataInput formData) {
    final indexOfToday =
        findDailyDataInputIndexByDate(user.dailyDataInput, DateTime.now());
    logger.d(user.dailyDataInput[indexOfToday]);
    user.dailyDataInput[indexOfToday].temperature = formData.temperature;
    user.dailyDataInput[indexOfToday].discharge = formData.discharge;
    user.dailyDataInput[indexOfToday].hoursOfSleep = formData.hoursOfSleep;
    user.dailyDataInput[indexOfToday].energyLevel = formData.energyLevel;
    user.dailyDataInput[indexOfToday].blood = formData.blood;
    logger.d(
        "User's today' dailyDataInput after updating with info from DDI widget");
    logger.d(user.dailyDataInput[indexOfToday]);
  }

  //Run the algorithm before updating the user's data in firebase
  runAlgorithmAfterUserSubmitsData(UserModel user) {
    try {
      updateUsersAlgorithmData(user);
      List<String> tags = produceTagsForToday(user);
      redrawCalendar(user, tags);
      List<String> insightIds = chooseInsightIdsBasedOnListOfTags(user, tags);
      List<Map<String, dynamic>> insights =
          retrieveInsightsByTheirIds(insightIds);
      logger.d(insights);
    } catch (e) {
      logger.d("Error running algorithm after user submits data: $e");
    }
  }

  int findDailyDataInputIndexByDate(
      List<DailyDataInput> dailyDataInputs, DateTime targetDate) {
    for (int i = 0; i < dailyDataInputs.length; i++) {
      DailyDataInput input = dailyDataInputs[i];
      if (input.date.year == targetDate.year &&
          input.date.month == targetDate.month &&
          input.date.day == targetDate.day) {
        return i;
      }
    }
    return -1; // Return -1 if no matching date is found
  }

  Future<void> updateNewUserToFirestore(userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.email)
          .set({'name': userModel.name, 'email': userModel.email});
    } catch (e) {
      logger.d('Error adding data to Firestore: $e');
    }
  }

  void saveFeedback(String text, String text2) {
    try {
      FirebaseFirestore.instance.collection('feedback').add({
        'feedback': text,
        'email': text2,
      });
    } catch (e) {
      logger.d('Error adding data to Firestore: $e');
    }
  }
}
