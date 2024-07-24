import 'package:by_cycle/algorithms/all_insights.dart';

List<Map<String, dynamic>> retrieveInsightsByTheirIds(List<String> insightIds) {
  return allInsights
      .where((insight) => insightIds.contains(insight['id']))
      .toList();
}
