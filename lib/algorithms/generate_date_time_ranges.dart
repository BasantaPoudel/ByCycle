import 'package:by_cycle/examples/users/user_after_onboardCalendar.dart';
import 'package:by_cycle/models/custom_date_time_range.dart';
import 'package:by_cycle/models/user.dart';
import 'package:by_cycle/models/daily_data_input.dart';
import 'package:logger/logger.dart';

var logger = Logger();

List<CustomDateTimeRange> generateDateTimeRanges(User user) {
  /*a function for creating a list of ranges of specific phases based on
  user's dailyDataInputs. 

  Parameters:
    - an instance of user

  Returns:
    -a list of CustomDateTimeRanges, each has start and end dates and a phase.
    A list of CustomDateTimeRanges is what Calendar needs to color each phase

  This function is used at least in onboardCalendar and redrawCalendar
  */
  List<CustomDateTimeRange> dateTimeRanges = [];

  CustomDateTimeRange? currentRange;
  String currentPhase = '';

  for (int i = 0; i < user.dailyDataInput.length; i++) {
    DailyDataInput data = user.dailyDataInput[i];

    // Check if phase changes
    if (data.phase != currentPhase) {
      // If we were in a phase, finalize the range
      if (currentRange != null) {
        dateTimeRanges.add(currentRange);
      }

      // Start a new range for the new phase
      currentPhase = data.phase;
      currentRange = CustomDateTimeRange(
          start: data.date, end: data.date, phase: currentPhase);
    } else {
      // Continue extending the current range
      currentRange = CustomDateTimeRange(
          start: currentRange!.start, end: data.date, phase: currentPhase);
    }
  }

  // Finalize the last range
  if (currentRange != null) {
    dateTimeRanges.add(currentRange);
  }

  return dateTimeRanges;
}

void main() {
  logger.d(generateDateTimeRanges(user_after_onboardCalendar));
}
