import 'package:by_cycle/algorithms/choose_insight_ids_based_on_list_of_tags.dart';
import 'package:by_cycle/algorithms/produce_tags.dart';
import 'package:by_cycle/algorithms/redraw_calendar.dart';
import 'package:by_cycle/algorithms/retrieve_insights_by_their_ids.dart';
import 'package:by_cycle/algorithms/update_users_algorithm_data.dart';
import 'package:by_cycle/examples/users/new_ovulating_user.dart';

void main() {
  var user = new_ovulating_user;
  updateUsersAlgorithmData(user);
  List<String> tags = produceTagsForToday(user);
  redrawCalendar(user, tags);
  List<String> insightIds = chooseInsightIdsBasedOnListOfTags(user, tags);
  List<Map<String, dynamic>> insights = retrieveInsightsByTheirIds(insightIds);
  print(insights);
}
