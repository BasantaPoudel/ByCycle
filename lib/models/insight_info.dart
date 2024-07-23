class InsightInfo {
  String insightId;
  int viewCounter;
  List<String> tags;

  InsightInfo({
    required this.insightId,
    required this.viewCounter,
    required this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'insightId': insightId,
      'viewCounter': viewCounter,
      'tags': tags,
    };
  }

  factory InsightInfo.fromMap(Map<String, dynamic> map) {
    return InsightInfo(
      insightId: map['insightId'] ?? '',
      viewCounter: map['viewCounter'] ?? 0,
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  @override
  String toString() {
    return 'InsightInfo(insightId: $insightId, viewCounter: $viewCounter, tags: $tags)';
  }
}
