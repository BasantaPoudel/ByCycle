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

        print("User updated successfully!");
      } else {
        print("No user found with the given email.");
      }
      // } catch (e) {
      //   print("Failed to update user: $e");
      // }

      // try {

      // await FirebaseFirestore.instance
      //     .collection('onboarding')
      //     .add(formData.toMap());
    } catch (e) {
      logger.d('Error adding data to Firestore: $e');
    }

    //   if (documentId != null) {
    //     await FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(documentId)
    //         .set(data.toMap());
    //   } else {
    //     await FirebaseFirestore.instance.collection('users').add(data.toMap());
    //   }
    // } catch (e) {
    //   logger.d('Error adding data to Firestore: $e');
    // }
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

//Random method to try out on new user
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
          // name: doc.get(name).toString(),
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
    updateUserOnboardingData(user, formData);

    //TODO - This is a temporary solution to get the user's data
    onboardCalendar(user);

    // Steps of execution from algorithm.dart
    updateUsersAlgorithmData(user);
    List<String> tags = produceTagsForToday(user);
    redrawCalendar(user, tags);
    List<String> insightIds = chooseInsightIdsBasedOnListOfTags(user, tags);
    List<Map<String, dynamic>> insights =
        retrieveInsightsByTheirIds(insightIds);

    logger.d(insights);

    // await sendDailyData(user.dailyDataInput.last);
    await updateUserInFirebase(user);
  }

  updateUserOnboardingData(UserModel user, OnBoardingQuestions formData) {
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

//TODO - Might be completely irrelevant at this point but I'm leaving it here for now as an example
  Future<String> getTodaysPhase() async {
    UserModel user =
        await getUserByEmailFromFirestore(loggedInUser!.email!) as UserModel;
    try {
      // DocumentSnapshot snapshot = await FirebaseFirestore.instance
      //     .collection("users")
      //     //TODO - Change this to the user's id
      //     // new_pb_longer_cycle
      //     // in menstruation

      //     // new_pcos_pa
      //     // in luteal

      //     // new_pa_lucia
      //     // in follicular

      //     // new_ovulating user
      //     // in ovulation
      //     .doc("new_pa_lucia")
      //     .get();

      // var data = snapshot.data() as Map<String, dynamic>;
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

  // // a handy function for identifying the index of a dailyDataInput on a specific day.
  // int findDailyDataInputIndexByDate(
  //     List<DailyDataInput> dailyDataInputs, DateTime targetDate) {
  //   for (int i = 0; i < dailyDataInputs.length; i++) {
  //     dynamic input = dailyDataInputs[i];
  //     DateTime inputDate = input['date'].toDate();
  //     if (inputDate.year == targetDate.year &&
  //         inputDate.month == targetDate.month &&
  //         inputDate.day == targetDate.day) {
  //       return i;
  //     }
  //   }
  //   return -1; // Return -1 if no matching date is found
  // }

  Future<void> saveDailyDataInputData(DailyDataInput formData) async {
    String email = loggedInUser!.email!;

    UserModel user = await getUserByEmailFromFirestore(email) as UserModel;
    logger.d(
        "User's today' dailyDataInput after updating with info from DDI widget");
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

    // Steps of execution from algorithm.dart
    updateUsersAlgorithmData(user);
    List<String> tags = produceTagsForToday(user);
    redrawCalendar(user, tags);
    List<String> insightIds = chooseInsightIdsBasedOnListOfTags(user, tags);
    List<Map<String, dynamic>> insights =
        retrieveInsightsByTheirIds(insightIds);

    logger.d(insights);

    updateUserInFirebase(user);
  }

  Future<List<CustomDateTimeRange>> getPhaseRanges() async {
    UserModel user =
        await getUserByEmailFromFirestore(loggedInUser!.email!) as UserModel;
    return user.phaseRanges;
  }
}
