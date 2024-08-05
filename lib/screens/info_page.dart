import 'package:by_cycle/algorithms/update_users_algorithm_data.dart';
import 'package:by_cycle/models/custom_date_time_range.dart';
import 'package:by_cycle/models/user_model.dart';
import 'package:by_cycle/screens/info_pages/info_page_follicular.dart';
import 'package:by_cycle/screens/info_pages/info_page_luteal.dart';
import 'package:by_cycle/screens/info_pages/info_page_menstruation.dart';
import 'package:by_cycle/screens/info_pages/info_page_ovulation.dart';

import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final UserModel currentUser;

  const InfoPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    // Compute the index of today
    final indexOfToday = findDailyDataInputIndexByDate(
        currentUser.dailyDataInput, DateTime.now());
    final currentPhase = currentUser.dailyDataInput[indexOfToday].phase;

    // Compute the progress and phase color
    final currentDateTimeRange = findCurrentPhaseDateTimeRange(currentUser);
    final phaseProgressPercentage =
        findProgressPercentage(currentDateTimeRange);
    final phaseColor = _getPhaseColor(currentPhase);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 46.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headlineMedium,
                children: <TextSpan>[
                  TextSpan(
                    text: 'You\'re in the ',
                  ),
                  TextSpan(
                    text: '${adjustedPhase(currentPhase)} phase',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: LinearProgressIndicator(
                minHeight: 10,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                value: phaseProgressPercentage,
                backgroundColor: const Color.fromRGBO(222, 212, 197, 1),
                valueColor: AlwaysStoppedAnimation<Color>(phaseColor),
              ),
            ),
            const SizedBox(height: 47.0),
            //const InfoPageLuteal(),
            _buildInfoPage(currentPhase), // Display the correct info page
          ],
        ),
      ),
    );
  }

  Color _getPhaseColor(String? phase) {
    switch (phase) {
      case 'follicular':
        return const Color(0xFF8E79BB);
      case 'ovulation':
        return const Color(0xFF85A79D);
      case 'luteal':
        return const Color(0xFFD6A879);
      case 'menstruation':
        return const Color(0xFFD48078);
      default:
        return Colors.grey; // Default color
    }
  }

  CustomDateTimeRange findCurrentPhaseDateTimeRange(UserModel user) {
    var currentPhaseDateTimeRange = CustomDateTimeRange(
        start: DateTime.now(), end: DateTime.now(), phase: '');
    if (user.phaseRanges == null) return currentPhaseDateTimeRange;
    user.phaseRanges.firstWhere((element) {
      var phaseStart =
          DateTime(element.start.year, element.start.month, element.start.day);
      var phaseEnd =
          DateTime(element.end.year, element.end.month, element.end.day);
      var currentTime = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);

      logger.d('Phase start: $phaseStart');
      logger.d('Phase end: $phaseEnd');
      logger.d('Current time: $currentTime');

      if ((currentTime.isAfter(phaseStart) && currentTime.isBefore(phaseEnd)) ||
          currentTime.isAtSameMomentAs(phaseStart) ||
          currentTime.isAtSameMomentAs(phaseEnd)) {
        currentPhaseDateTimeRange = element;
        return true;
      }
      return false;
    });
    return currentPhaseDateTimeRange;
  }

  double findProgressPercentage(CustomDateTimeRange currentDateTimeRange) {
    var phaseStart = DateTime(currentDateTimeRange.start.year,
        currentDateTimeRange.start.month, currentDateTimeRange.start.day);
    var phaseEnd = DateTime(currentDateTimeRange.end.year,
        currentDateTimeRange.end.month, currentDateTimeRange.end.day);
    var currentTime =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    // Added one day to adjust the difference in days
    var totalLength = phaseEnd.difference(phaseStart).inDays + 1;
    var currentProgress = currentTime.difference(phaseStart).inDays + 1;

    var progressPercentage = currentProgress / totalLength;
    return progressPercentage;
  }
}

String adjustedPhase(String phase) {
  if (phase == 'menstruation') {
    return 'menstrual';
  } else if (phase == 'ovulation') {
    return 'ovulatory';
  }
  return phase;
}

Widget _buildInfoPage(String phase) {
  switch (phase) {
    case 'follicular':
      return const InfoPageFollicular(); // Define this widget
    case 'ovulation':
      return const InfoPageOvulation(); // Define this widget
    case 'luteal':
      return const InfoPageLuteal();
    case 'menstruation':
      return const InfoPageLuteal(); // Define this widget
    default:
      return const Center(child: Text('Unknown phase')); // Handle unknown phase
  }
}
