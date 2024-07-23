import 'package:by_cycle/models/user.dart';
import 'package:by_cycle/models/daily_data_input.dart';

List<String> chooseInsightIdsBasedOnListOfTags(User user, List<String> tags) {
  /*A function that returns 3 ids of insights that should be shown to the user 
  based on the provided list of tags.
  Tags are produced by produceTags which in turn uses functions A-F in a different file,
  and this function selects which ones are suitable for the user based on how many times they
  were seen.

  Parameters:
  -a user instance. A user instance itself has the property "tags" that contains
  information on which insights were shown and how many times)
  -a List<String> of tags e.g. ["blood", "backpain"...], can be a long list

  Returns:
  -A list of at most 3 insights ids as strings. Each InsightInfo instance contains an
  insightId that can be used to retrieve the right insight.

  Side-effects:
  -increases the viewCount of those InsightInfos that are shown in the end
  and all of their copies inside other tags.
  */

  //primary list collects InsightInfos that weren't shown before
  List<InsightInfo> primaryList = [];
  //secondary list collects InsightInfos that were shown before
  List<InsightInfo> secondaryList = [];
  for (var tag in tags) {
    if (user.tags.containsKey(tag)) {
      print(user.tags[tag]);
      InsightInfo lowestViewInsight = user.tags[tag]!.reduce((current, next) =>
          current.viewCounter < next.viewCounter ? current : next);

      if (lowestViewInsight.viewCounter == 0) {
        primaryList.add(
            lowestViewInsight); // Add the tag with the lowest viewCounter to out list
      } else {
        secondaryList.add(lowestViewInsight);
      }
    } else {
      print("No matching insight for ${tag} in user.tags or tag is empty");
    }
  }

  //combine the collected InsightInfos into one list
  List<InsightInfo> combinedList = primaryList + secondaryList;

  // Shorten down to at most the first three elements
  combinedList =
      combinedList.length > 3 ? combinedList.sublist(0, 3) : combinedList;

  //increase the viewCount of the InsightInfo appearing under different tags
  for (var insightInfo in combinedList) {
    for (var tag in tags) {
      if (user.tags.containsKey(tag)) {
        for (var insight in user.tags[tag]!) {
          if (insight.insightId == insightInfo.insightId) {
            insight.viewCounter++;
          }
        }
      }
    }
  }

  return combinedList.map((insightInfo) => insightInfo.insightId).toList();
}
